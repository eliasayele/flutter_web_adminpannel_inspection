import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/constants.dart';
import 'package:inspection_admin/controllers/AppState.dart';
import 'package:inspection_admin/models/Summary.dart';
import 'package:inspection_admin/services/api.dart';
import 'package:inspection_admin/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'components/HeaderCards.dart';
import 'components/UpgradeCar.dart';
import 'components/chart.dart';
import 'components/header.dart';
import 'components/inspection_config_cards.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Summary? summary;

  Future getSummary(appState) async {
    appState.setAppState(NotifierState.busy);
    try {
      summary = await ApiServices().loadSummary();
      appState.setAppState(NotifierState.ideal);
    } catch (e) {
      appState.setAppState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }

    return summary;
  }

  bool firstTime = true;
  @override
  void didChangeDependencies() {
    if (firstTime) {
      firstTime = false;
      var appState = Provider.of<AppState>(context);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        getSummary(appState);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          child: appState.getState == NotifierState.ideal
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Header(),
                    SizedBox(height: defaultPadding * 2),
                    Row(
                      children: [
                        TotalCard(
                          title: "Inspections",
                          total: summary!.data.totalInspections.toString(),
                          percent: "25%",
                          color: Color(0xFF737CC6),
                        ),
                        SizedBox(
                            width: !Responsive.isMobile(context)
                                ? defaultPadding * 2
                                : defaultPadding * 2.5),
                        TotalCard(
                          title: "Employees",
                          total: summary!.data.employes.toString(),
                          percent: "25%",
                          color: Color(0xFF667A73),
                        ),
                        if (!Responsive.isMobile(context)) Spacer(),
                        if (!Responsive.isMobile(context))
                          Expanded(child: FillterCardHome(summary!))
                      ],
                    ),
                    SizedBox(height: defaultPadding * 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: Chart(summary!)),
                        if (!Responsive.isMobile(context))
                          SizedBox(width: defaultPadding),
                        if (!Responsive.isMobile(context))
                          Expanded(
                              flex: 1,
                              child: Container(
                                  width: 150,
                                  height: 300,
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Center(child: UpgradeCard()))),
                      ],
                    ),
                    SizedBox(height: defaultPadding * 1.5),
                    if (Responsive.isMobile(context))
                      Column(
                        children: [
                          UpgradeCard(),
                          SizedBox(height: defaultPadding * 1.5),
                          InspectionsCard(summary!),
                          SizedBox(height: defaultPadding),
                          ConfigurationsCard(summary!),
                        ],
                      ),
                    if (!Responsive.isMobile(context))
                      Row(
                        children: [
                          Expanded(child: InspectionsCard(summary!)),
                          SizedBox(width: defaultPadding * 2),
                          Expanded(child: ConfigurationsCard(summary!)),
                        ],
                      ),
                    SizedBox(height: defaultPadding * 1.5),
                  ],
                )
              : appState.getState == NotifierState.ideal
                  ? Center(
                      child: Text(
                        'Error Happen',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }
}

class FillterCardHome extends StatelessWidget {
  const FillterCardHome(
    this.summary, {
    Key? key,
  }) : super(key: key);
  final Summary summary;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: EdgeInsets.all(defaultPadding * 0.75),
      constraints: BoxConstraints(maxWidth: 150),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Filter By", style: TextStyle(color: Colors.black)),
          Text(
            "This Year, 2021",
            style: TextStyle(color: Colors.black),
            //style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
