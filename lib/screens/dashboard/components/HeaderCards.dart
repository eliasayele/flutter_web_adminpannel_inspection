import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({
    Key? key,
    required this.title,
    required this.total,
    required this.percent,
    required this.color,
  }) : super(key: key);
  final String title;
  final String total;
  final String percent;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(defaultPadding * 0.50),
        height: 82,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                SvgPicture.asset(
                    "assets/admin/Dashboard/inspection_car_icon.svg"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(total, style: TextStyle(fontSize: 25)),
                Row(
                  children: [
                    Icon(Icons.navigation_outlined, color: Colors.white),
                    Text(percent),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
