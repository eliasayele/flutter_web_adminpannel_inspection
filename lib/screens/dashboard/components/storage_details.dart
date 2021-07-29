import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFA87DF1),
          Color(0xFF7C3CE9),
          Color(0xFF8350DB),
        ]),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Upgrade your"
              " subscription",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.white70,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Upgrade Now",
                style: TextStyle(color: Color(0xFFA87DF1)),
              ),
            ),
          ),
          // Chart(),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/Documents.svg",
          //   title: "Documents File",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media File",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other File",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
        ],
      ),
    );
  }
}
