import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_admin/models/RecentFile.dart';
import 'package:inspection_admin/screens/InspectionsDashboard/SortableTable.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inspections",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "More than 250+ new",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black,
                          fontSize: 10,
                          letterSpacing: -0.3,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/admin/Garages/print.svg",
                height: 15,
              ),
              SizedBox(width: defaultPadding),
              SvgPicture.asset("assets/admin/Garages/download.svg", height: 15),
              Container(
                margin: EdgeInsets.all(defaultPadding),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/Filter.svg", height: 10),
                    SizedBox(width: defaultPadding),
                    Text(
                      "Sort A-Z",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.black, fontSize: 10),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
          if (!Responsive.isMobile(context))
            SizedBox(
              width: double.infinity,
              child: SortablePage(),
            ),
          if (Responsive.isMobile(context))
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: SortablePage()),
            ),
        ],
      ),
    );
  }

  DataRow recentFileDataRow(RecentFile fileInfo, TextStyle textStyle, context) {
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                fileInfo.title,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          fileInfo.date,
          style: textStyle,
        ),
      ),
      DataCell(Text(
        fileInfo.size,
        style: textStyle,
      )),
      DataCell(Text(
        fileInfo.size,
        style: textStyle,
      )),
      DataCell(Text(
        fileInfo.size,
        style: textStyle,
      )),
    ]);
  }
}
