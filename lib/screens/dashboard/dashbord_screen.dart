import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/constants.dart';
import 'package:inspection_admin/controllers/AppState.dart';
import 'package:inspection_admin/controllers/FilterNotifieer.dart';
import 'package:inspection_admin/controllers/FilterProvider.dart';
import 'package:inspection_admin/controllers/SummaryNotifier.dart';
import 'package:inspection_admin/locator.dart';
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
  var summary = locator<SummaryNotifier>();
  // Summary? summary;

  Future<void> getSummary(appState, context) async {
    appState.setAppState(NotifierState.busy);
    try {
      summary.setSummary(await ApiServices().loadSummary());
      appState.setAppState(NotifierState.ideal);
    } catch (e) {
      appState.setAppState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }
  }

  bool firstTime = true;
  @override
  void didChangeDependencies() {
    if (firstTime) {
      firstTime = false;
      var appState = Provider.of<AppState>(context);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        getSummary(appState, context);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    var filterState = Provider.of<FilterProvider>(context);
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
                          total: summary.getSummary!.data.inspections.all
                              .toString(),
                          percent:
                              "${summary.getSummary!.data.inspections.change / 100}%",
                          color: Color(0xFF737CC6),
                        ),
                        SizedBox(
                            width: !Responsive.isMobile(context)
                                ? defaultPadding * 2
                                : defaultPadding * 2.5),
                        TotalCard(
                          title: "Employees",
                          total:
                              summary.getSummary!.data.employes.all.toString(),
                          percent:
                              "${summary.getSummary!.data.employes.change / 100}%",
                          color: Color(0xFF667A73),
                        ),
                        if (!Responsive.isMobile(context)) Spacer(),
                        if (!Responsive.isMobile(context))
                          Expanded(child: FillterCardHome(summary.getSummary!))
                      ],
                    ),
                    SizedBox(height: defaultPadding * 2),
                    if (Responsive.isMobile(context))
                      FillterCardHome(summary.getSummary!),
                    SizedBox(height: defaultPadding * 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterState.getState == NotifierState.ideal
                            ? Expanded(
                                flex: 3, child: Chart(summary.getSummary!))
                            : Expanded(
                                flex: 3,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
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
                          filterState.getState == NotifierState.ideal
                              ? InspectionsCard(summary.getSummary!)
                              : Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                          SizedBox(height: defaultPadding),
                          filterState.getState == NotifierState.ideal
                              ? ConfigurationsCard(summary.getSummary!)
                              : Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator())),
                        ],
                      ),
                    if (!Responsive.isMobile(context))
                      Row(
                        children: [
                          filterState.getState == NotifierState.ideal
                              ? Expanded(
                                  child: InspectionsCard(summary.getSummary!))
                              : Center(child: CircularProgressIndicator()),
                          SizedBox(width: defaultPadding * 2),
                          filterState.getState == NotifierState.ideal
                              ? Expanded(
                                  child:
                                      ConfigurationsCard(summary.getSummary!))
                              : Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                        ],
                      ),
                    SizedBox(height: defaultPadding * 1.5),
                  ],
                )
              : appState.getState == NotifierState.error
                  ? Center(
                      child: Text('Error Happen',
                          style: Theme.of(context).textTheme.headline3))
                  : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class FillterCardHome extends StatefulWidget {
  const FillterCardHome(
    this.summary, {
    Key? key,
  }) : super(key: key);
  final Summary summary;

  @override
  _FillterCardHomeState createState() => _FillterCardHomeState();
}

class _FillterCardHomeState extends State<FillterCardHome> {
  String dropdownValue = 'this year';

  var datedata = locator<FilterNotifier>();
  var summary = locator<SummaryNotifier>();

  Future<void> FilterByMonth(BuildContext context, filterState) async {
    DateTime now = DateTime.now();
    String newDate =
        DateTime(now.year, now.month - 1, now.day).toUtc().toIso8601String();
    datedata.setFrom(newDate);
    filterState.setFilterState(NotifierState.busy);

    try {
      summary.setSummary(await ApiServices().loadSummary());
      filterState.setFilterState(NotifierState.ideal);
    } catch (e) {
      filterState.setFilterState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }
    //getSummary(appState, context);
  }

  Future<void> FilterByYear(BuildContext context, filterState) async {
    DateTime now = DateTime.now();
    String newDate =
        DateTime(now.year - 1, now.month, now.day).toUtc().toIso8601String();
    datedata.setFrom(newDate);
    filterState.setFilterState(NotifierState.busy);
    try {
      summary.setSummary(await ApiServices().loadSummary());
      filterState.setFilterState(NotifierState.ideal);
    } catch (e) {
      filterState.setFilterState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> FilterByWeek(BuildContext context, filterState) async {
    DateTime now = DateTime.now();
    String newDate =
        DateTime(now.year, now.month, now.day - 2).toUtc().toIso8601String();
    datedata.setFrom(newDate);

    filterState.setFilterState(NotifierState.busy);
    try {
      summary.setSummary(await ApiServices().loadSummary());
      filterState.setFilterState(NotifierState.ideal);
    } catch (e) {
      filterState.setFilterState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var filterState = Provider.of<FilterProvider>(context);
    return Container(
      height: 80,
      padding: EdgeInsets.all(defaultPadding * 0.75),
      constraints:
          BoxConstraints(maxWidth: !Responsive.isMobile(context) ? 150 : 900),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Filter by ", style: TextStyle(color: Colors.black54)),
          Container(
            height: 50,
            color: Colors.white,
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  iconEnabledColor: Colors.amber.shade700,
                  value: dropdownValue,
                  iconSize: 22,
                  elevation: 10,
                  onChanged: (String? newValue) {
                    setState(() {
                      newValue == "this year"
                          ? FilterByYear(context, filterState)
                          : newValue == "this month"
                              ? FilterByMonth(context, filterState)
                              : FilterByWeek(context, filterState);
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['this year', 'this month', 'this week']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
