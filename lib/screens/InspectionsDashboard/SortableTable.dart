import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:inspection_admin/controllers/AppState.dart';
import 'package:inspection_admin/models/CompletedInspections.dart';
import 'package:inspection_admin/services/api.dart';
import 'package:inspection_admin/widgets/show_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SortablePage extends StatefulWidget {
  @override
  _SortablePageState createState() => _SortablePageState();
}

class _SortablePageState extends State<SortablePage> {
  late CompletedInspections inspections;
  int? sortColumnIndex;
  bool isAscending = false;
  bool status = false;
  Future<void> getInspections(appState, context) async {
    appState.setAppState(NotifierState.busy);
    try {
      inspections = await ApiServices().fetchInspections();
      appState.setAppState(NotifierState.ideal);
    } catch (e) {
      appState.setAppState(NotifierState.error);
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool firstTime = true;
  @override
  void didChangeDependencies() {
    if (firstTime) {
      firstTime = false;
      var appState = Provider.of<AppState>(context);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        getInspections(appState, context);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    TextStyle textStyle = Theme.of(context)
        .textTheme
        .subtitle1!
        .copyWith(color: Colors.black, fontSize: 13);
    return appState.getState == NotifierState.ideal
        ? buildDataTable(textStyle)
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildDataTable(textStyle) {
    final columns = [' Inspector', 'Company', 'Date', 'Status', 'Action'];
    return DataTable(
      columnSpacing: defaultPadding,
      dataTextStyle: textStyle,
      showBottomBorder: true,
      horizontalMargin: 0,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns, textStyle),
      rows: getRows(inspections.data.data, textStyle),
      headingRowColor: MaterialStateProperty.resolveWith(
        (Set states) {
          if (states.contains(MaterialState.selected))
            return Colors.blueGrey.withOpacity(0.3);
          return Colors.blueGrey.withOpacity(0.3); // Use the default value.
        },
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns, textStyle) => columns
      .map((String column) => DataColumn(
            label: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  SvgPicture.asset("assets/admin/Company/AZ.svg"),
                  SizedBox(width: defaultPadding),
                  Text(column, style: textStyle),
                ],
              ),
            ),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<VehicleData> inspect, textStyle) =>
      inspect.map((VehicleData inspect) {
        final timeFormat = new DateFormat('yyyy-MM-dd');
        final cells = [
          inspect.inspector.firstName + " " + inspect.inspector.middleName,
          "Ride",
          timeFormat.format(inspect.createdAt),
          inspect.status,
          "seen",
        ];

        return DataRow(cells: getCells(cells, textStyle));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells, textStyle) => cells.map((data) {
        return DataCell(
          data == cells[0]
              ? Row(
                  children: [
                    Container(
                      height: 40,
                      color: Colors.green,
                      width: 3,
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Image.asset("assets/images/profile_pic.png", height: 40),
                    Text('$data', style: textStyle),
                  ],
                )
              : data == cells[3]
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      height: 100,
                      width: 150,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: data == "APPROVED"
                            ? Colors.lightGreen.withOpacity(0.5)
                            : data == "PENDING"
                                ? Colors.brown.withOpacity(0.5)
                                : Colors.redAccent.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Text(
                          '$data',
                          style: TextStyle(
                            color: data == "APPROVED"
                                ? Colors.green
                                : data == "PENDING"
                                    ? Colors.brown
                                    : Colors.redAccent,
                          ),
                        ),
                      ),
                    )
                  : data == cells[4]
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.teal.shade300,
                              child: FlutterSwitch(
                                activeIcon: Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Color(0xFF24a7ad),
                                ),
                                inactiveIcon: Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                switchBorder: Border.all(
                                    color: Color(0xFF24a7ad), width: 2.5),
                                toggleSize: 15.0,
                                width: 40.0,
                                height: 19.0,
                                valueFontSize: 2.0,
                                value: status,
                                borderRadius: 30.0,
                                padding: 2.2,
                                // toggleBorder: Border.all(
                                //     color: Color(0xFF24a7ad), width: 3),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white,
                                activeToggleColor: Color(0xFF24a7ad),
                                inactiveToggleColor: Colors.grey,
                                onToggle: (val) {
                                  setState(() {
                                    status = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: defaultPadding),
                            InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                    "assets/admin/Config/View.svg")),
                          ],
                        )
                      : Text('$data', style: textStyle),
        );
      }).toList();

  void onSort(int columnIndex, bool ascending) {
    // if (columnIndex == 0) {
    //   inspections.sort((inspection1, inspection2) => compareString(
    //       ascending, inspection1.inspector, inspection2.inspector));
    // } else if (columnIndex == 1) {
    //   inspections.sort((inspection1, inspection2) =>
    //       compareString(ascending, inspection1.company, inspection2.company));
    // } else if (columnIndex == 2) {
    //   inspections.sort((inspection1, inspection2) =>
    //       compareString(ascending, inspection1.date, inspection2.date));
    // } else if (columnIndex == 3) {
    //   inspections.sort((inspection1, inspection2) =>
    //       compareString(ascending, inspection1.status, inspection2.status));
    // }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
