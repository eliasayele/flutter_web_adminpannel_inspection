import 'package:flutter/material.dart';
import 'package:inspection_admin/screens/dashboard/components/header.dart';
import 'package:inspection_admin/screens/dashboard/components/recent_files.dart';

import '../../constants.dart';

class InspectionsDashboard extends StatelessWidget {
  const InspectionsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              SizedBox(height: defaultPadding),

              ///search bar
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SearchField(),
                  ),
                  SizedBox(width: defaultPadding * 3),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 67,
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      constraints: BoxConstraints(maxWidth: 150),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Filter By",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.yellowAccent,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "This Year, 2021",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            //style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // if (!Responsive.isMobile(context))
              //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              // SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //Chart(),
                        SizedBox(height: defaultPadding),

                        // SizedBox(
                        //   height: defaultPadding,
                        // ),
                        // MyFiels(),
                        // SizedBox(height: defaultPadding),
                        RecentFiles(),
                        // if (Responsive.isMobile(context))
                        //   SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  // if (!Responsive.isMobile(context))
                  //   SizedBox(width: defaultPadding),
                  //if (!Responsive.isMobile(context)),
                  // Expanded(flex: 2, child: StorageDetails()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
