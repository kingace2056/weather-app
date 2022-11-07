import 'package:flutter/material.dart';

import 'package:weather_app/constants/color_constants.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.title,
    required this.values,
  }) : super(key: key);
  final String title;
  final String values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: primWhite, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Text(
            values,
            style: TextStyle(
                color: primWhite, fontSize: 17, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
