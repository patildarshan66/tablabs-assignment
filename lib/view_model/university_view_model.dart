import 'package:demo_assignment/model/university.dart';
import 'package:demo_assignment/routes/route_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/apis/api_response.dart';
import '../model/services/urls.dart';
import '../model/university_repository.dart';
import '../utils/utils.dart';

class UniversityViewModel extends GetxController {
  final UniversityRepository _universityRepository = UniversityRepository();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<University>  _universityList = [];
  List<University>  _universitySearchList = [];

  List<University> get universityList {
    return _universityList;
  }

  List<University> get universitySearchList {
    return _universitySearchList;
  }

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> getUniversityList({bool isUniversityDeeplink = false, String universityName = ''}) async {
    await isConnected().then((value) async {
      _apiResponse = ApiResponse.loading('Data Received');
      update();
      try{
        _universitySearchList = _universityList =  await _universityRepository.fetchUniversityList(universityListUrl);
        _apiResponse = ApiResponse.completed('Data Received');
        if(isUniversityDeeplink){
          _openDeeplinkUniversityScreen(universityName);
        }
        update();
      }catch(e){
        _apiResponse = ApiResponse.error(e.toString());
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
        update();
      }
    }).onError((error, stackTrace){
      _apiResponse = ApiResponse.notInternet('No internet connection!');
      update();
    });
  }

  void searchUniversityName(String name){
    _universitySearchList = _universityList.where((element) => element.name.toLowerCase().contains(name.toLowerCase())).toList();
    update();
  }

  void resetSearch(){
    _universitySearchList = _universityList;
    update();
  }

  void _openDeeplinkUniversityScreen(String universityName) {
    final University data = _universityList.firstWhere((element) => element.name.toLowerCase() == universityName.toLowerCase());
    Get.toNamed(RoutePath.universityDetailsRoute,arguments: data);
  }
}