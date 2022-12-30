import 'package:demo_assignment/model/university.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_text_styles.dart';
import '../../utils/utils.dart';

class UniversityDetailsScreen extends StatelessWidget {
  final University data;
  const UniversityDetailsScreen({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'University Name: ',
                    style: body1_16ptMedium(),
                  ),
                  Expanded(child:Text(
                    data.name,
                    style: subTitle2_14ptRegular(color: Colors.black87),
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Country: ',
                    style: body1_16ptMedium(),
                  ),
                  Expanded(
                    child: Text(
                      '${data.country} ${data.alphaTwoCode}',
                      style: subTitle2_14ptRegular(color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (data.webPages.isNotEmpty)
                Text(
                  'Web Pages',
                  style: body1_16ptMedium(),
                ),
              const SizedBox(height: 5),
              ...List.generate(
                data.webPages.length,
                (index) => InkWell(
                  onTap: (){
                    launchURL(data.webPages[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      data.webPages[index],
                      style: subTitle2_14ptRegular(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (data.domains.isNotEmpty)
                Text(
                  'Domains',
                  style: body1_16ptMedium(),
                ),
              const SizedBox(height: 5),
              ...List.generate(
                data.domains.length,
                (index) => InkWell(
                  onTap: (){
                    launchURL('https://${data.domains[index]}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      data.domains[index],
                      style: subTitle2_14ptRegular(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
