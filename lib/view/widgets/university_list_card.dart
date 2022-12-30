import 'package:demo_assignment/model/university.dart';
import 'package:flutter/material.dart';

class UniversityListCard extends StatelessWidget {
  const UniversityListCard({Key? key, required this.data}) : super(key: key);
  final University data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: Colors.grey
          )
        ]
          // border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: ListTile(
        leading: const Icon(Icons.school_rounded),
        title: Text(data.name),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
