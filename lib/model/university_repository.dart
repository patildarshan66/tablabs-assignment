import 'package:demo_assignment/model/services/base_service.dart';
import 'package:demo_assignment/model/services/university_service.dart';

import 'university.dart';


class UniversityRepository {
  final BaseService _universityService = UniversityService();

  Future<List<University>> fetchUniversityList(String value) async {
    dynamic response = await _universityService.getResponse(value);
    List<University> universityList = List<University>.from(response.map((tagJson) => University.fromMap(tagJson)));
    return universityList;
  }
}
