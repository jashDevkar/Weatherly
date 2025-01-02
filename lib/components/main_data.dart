import 'package:flutter/material.dart';
import 'package:weatherly/utils/constants.dart';

class MainData extends StatelessWidget {
  Map<String, dynamic> myDataMap;
  MainData({super.key, required this.myDataMap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: myDataMap.entries.map((item) {
            return Text(
              '${item.key}: ${item.value}',
              style: kDetailTextStyle,
            );
          }).toList()),
    ));
  }
}
