import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/constants.dart';

import '../../responsive.dart';
import 'components/HeaderCards.dart';
import 'components/chart.dart';
import 'components/header.dart';
import 'components/inspection_config_cards.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  TotalCard(
                    title: "Inspections",
                    total: "80,000",
                    percent: "25%",
                    color: Color(0xFF737CC6),
                  ),
                  SizedBox(
                      width: !Responsive.isMobile(context)
                          ? defaultPadding * 0.75
                          : defaultPadding * 2),
                  TotalCard(
                    title: "Employees",
                    total: "80,000",
                    percent: "25%",
                    color: Color(0xFF667A73),
                  ),
                  if (!Responsive.isMobile(context)) Spacer(),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      child: Container(
                        height: 67,
                        padding: EdgeInsets.all(defaultPadding * 0.75),
                        constraints: BoxConstraints(maxWidth: 150),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Filter By",
                                style: TextStyle(color: Colors.black)),
                            Text(
                              "This Year, 2021",
                              style: TextStyle(color: Colors.black),
                              //style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: Chart()),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                        flex: 1,
                        child: Container(
                            width: 150,
                            height: 300,
                            constraints: BoxConstraints(maxWidth: 200),
                            child: StorageDetails())),
                ],
              ),
              SizedBox(height: defaultPadding * 1.5),
              if (Responsive.isMobile(context))
                Column(
                  children: [
                    StorageDetails(),
                    SizedBox(height: defaultPadding * 1.5),
                    InspectionsCard(),
                    SizedBox(height: defaultPadding),
                    ConfigurationsCard(),
                  ],
                ),
              if (!Responsive.isMobile(context))
                Row(
                  children: [
                    Expanded(child: InspectionsCard()),
                    SizedBox(width: defaultPadding),
                    Expanded(child: ConfigurationsCard()),
                  ],
                ),
              SizedBox(height: defaultPadding * 1.5),
            ],
          ),
        ),
      ),
    );
  }
}
