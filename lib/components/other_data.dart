import 'package:flutter/material.dart';
import 'package:weatherly/utils/constants.dart';

class OtherData extends StatelessWidget {
  final Map<String, dynamic> myOtherData;
  const OtherData({super.key, required this.myOtherData});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: myOtherData.entries.map((entry) {
          return Text(
            '${entry.key}: ${entry.value} ',
            style: kDetailTextStyle,
          );
        }).toList(),
      ),
    );
  }
}
