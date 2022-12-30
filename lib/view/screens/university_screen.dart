import 'package:demo_assignment/utils/enums.dart';
import 'package:demo_assignment/view_model/university_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_strings.dart';
import '../../utils/utils.dart';
import '../widgets/university_list_card.dart';

class UniversityScreen extends StatefulWidget {
  final bool isUniversityDeeplink;
  final String universityName;
  const UniversityScreen({Key? key, this.isUniversityDeeplink = false, this.universityName = ''}) : super(key: key);

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  final UniversityViewModel _universityViewModel =
      Get.put(UniversityViewModel());
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _universityViewModel.getUniversityList(isUniversityDeeplink: widget.isUniversityDeeplink,universityName: widget.universityName);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: _universityViewModel,
          builder: (controller) {
            return _getBody();
          },
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_universityViewModel.response.status) {
      case Status.COMPLETED:
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: _universityViewModel.searchUniversityName,
                decoration: const InputDecoration(
                  hintText: 'Search university name..',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: _universityViewModel.universitySearchList.isEmpty
                  ? const Center(
                      child: Text('No university found with this name.'),
                    )
                  : ListView.builder(
                      itemCount:
                          _universityViewModel.universitySearchList.length,
                      itemBuilder: (ctx, i) {
                        final data =
                            _universityViewModel.universitySearchList[i];
                        return InkWell(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Get.toNamed(RoutePath.universityDetailsRoute,
                                arguments: data);
                            if (_searchController.text.isNotEmpty) {
                              _searchController.text = '';
                              _universityViewModel.resetSearch();
                            }
                          },
                          child: UniversityListCard(data: data),
                        );
                      },
                    ),
            )
          ],
        );
      case Status.ERROR:
      case Status.NOINTERNET:
        return Center(
          child: Text(_universityViewModel.response.message ?? ''),
        );
      case Status.LOADING:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
