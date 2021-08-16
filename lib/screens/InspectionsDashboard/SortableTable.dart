import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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

  Future<void> getInspections(appState, context, pageNum) async {
    appState.setAppState(NotifierState.busy);
    try {
      inspections = await ApiServices().fetchInspections(pageNum);
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
        getInspections(appState, context, 1);
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
        ? buildDataTable(textStyle, appState, context)
        : Center(child: CircularProgressIndicator());
  }

  Widget buildDataTable(textStyle, appState, context) {
    final columns = [' Inspector', 'Company', 'Date', 'Status', 'Action'];

    DataTableSource _data = MyData(inspections.data.data, textStyle);
    return PaginatedDataTable(
      columnSpacing: defaultPadding,
      source: _data,
      horizontalMargin: 0,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      showCheckboxColumn: false,
      columns: getColumns(columns, textStyle),
      // onRowsPerPageChanged: (index) {
      //   print("//////row number");
      //   print(index);
      // },
      // onPageChanged: (index) {
      //   print("//////row number");
      //   print(index);
      // },
      // actions: [],

      // rows: getRows(inspections.data.data, textStyle),
      // headingRowColor: MaterialStateProperty.resolveWith(
      //   (Set states) {
      //     if (states.contains(MaterialState.selected))
      //       return Colors.blueGrey.withOpacity(0.3);
      //     return Colors.blueGrey.withOpacity(0.3); // Use the default value.
      //   },
      // ),
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

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      inspections.data.data.sort((inspection1, inspection2) => compareString(
          ascending,
          inspection1.inspector.firstName,
          inspection2.inspector.firstName));
    } else if (columnIndex == 1) {
      // inspections.data.data.sort((inspection1, inspection2) =>
      //     compareString(ascending, inspection1.company, inspection2.company));
    } else if (columnIndex == 2) {
      inspections.data.data.sort((inspection1, inspection2) => compareString(
          ascending,
          inspection1.createdAt.toString(),
          inspection2.createdAt.toString()));
    } else if (columnIndex == 3) {
      inspections.data.data.sort((inspection1, inspection2) =>
          compareString(ascending, inspection1.status, inspection2.status));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

class MyData extends DataTableSource {
  MyData(this.inspection, this.textStyle);
  final List<VehicleData>? inspection;
  final TextStyle textStyle;
  final columns = [' Inspector', 'Company', 'Date', 'Status', 'Action'];
  bool get isRowCountApproximate => false;
  int get rowCount => inspection!.length;
  int get selectedRowCount => 0;

  ///let's li
  DataRow getRow(int index) {
    final timeFormat = new DateFormat('yyyy-MM-dd');
    final cells = [
      inspection![index].inspector.firstName +
          " " +
          inspection![index].inspector.middleName,
      "Ride",
      timeFormat.format(inspection![index].createdAt),
      inspection![index].status,
      "seen",
    ];
    return DataRow(
        cells: getCells(cells, textStyle, inspection![index].status));
  }

  List<DataCell> getCells(List<dynamic> cells, textStyle, status) =>
      cells.map((data) {
        return DataCell(
          data == cells[0]
              //first row
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
              //row three
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

                                value: status == "APPROVED"
                                    ? true
                                    : status == "PENDING"
                                        ? false
                                        : false,
                                borderRadius: 30.0,
                                padding: 2.2,
                                // toggleBorder: Border.all(
                                //     color: Color(0xFF24a7ad), width: 3),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white,
                                activeToggleColor: Color(0xFF24a7ad),
                                inactiveToggleColor: Colors.grey,
                                onToggle: (val) {
                                  // setState(() {
                                  //   status = val;
                                  // });
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

  // List<DataRow> getRows(List<VehicleData> inspect, textStyle) =>
  //     inspect.map((VehicleData inspect) {
  //       final timeFormat = new DateFormat('yyyy-MM-dd');
  //       final cells = [
  //         inspect.inspector.firstName + " " + inspect.inspector.middleName,
  //         "Ride",
  //         timeFormat.format(inspect.createdAt),
  //         inspect.status,
  //         "seen",
  //       ];
  //       return DataRow.byIndex(cells: getCells(cells, textStyle));
  //     }).toList();

  // var cells =  [
  //  inspection.inspector.firstName + " " + inspect.inspector.middleName,
  //  "Ride",
  //  timeFormat.format(inspect.createdAt),
  //  inspect.status,
  //  "seen",
  //  ];

}

// List<DataCell> getCells(List<dynamic> cells, textStyle) => cells.map((data) {
//       return DataCell(
//         data == cells[0]
//             ? Row(
//                 children: [
//                   Container(
//                     height: 40,
//                     color: Colors.green,
//                     width: 3,
//                   ),
//                   SizedBox(
//                     width: defaultPadding,
//                   ),
//                   Image.asset("assets/images/profile_pic.png", height: 40),
//                   Text('$data', style: textStyle),
//                 ],
//               )
//             : data == cells[3]
//                 ? Container(
//                     padding: EdgeInsets.symmetric(horizontal: 2),
//                     height: 100,
//                     width: 150,
//                     margin: EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 9,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                       color: data == "APPROVED"
//                           ? Colors.lightGreen.withOpacity(0.5)
//                           : data == "PENDING"
//                               ? Colors.brown.withOpacity(0.5)
//                               : Colors.redAccent.withOpacity(0.5),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '$data',
//                         style: TextStyle(
//                           color: data == "APPROVED"
//                               ? Colors.green
//                               : data == "PENDING"
//                                   ? Colors.brown
//                                   : Colors.redAccent,
//                         ),
//                       ),
//                     ),
//                   )
//                 : data == cells[4]
//                     ? Row(
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             splashColor: Colors.teal.shade300,
//                             child: FlutterSwitch(
//                               activeIcon: Icon(
//                                 Icons.circle,
//                                 size: 20,
//                                 color: Color(0xFF24a7ad),
//                               ),
//                               inactiveIcon: Icon(
//                                 Icons.circle,
//                                 size: 20,
//                                 color: Colors.grey,
//                               ),
//                               switchBorder: Border.all(
//                                   color: Color(0xFF24a7ad), width: 2.5),
//                               toggleSize: 15.0,
//                               width: 40.0,
//                               height: 19.0,
//                               valueFontSize: 2.0,
//                               value: status,
//                               borderRadius: 30.0,
//                               padding: 2.2,
//                               // toggleBorder: Border.all(
//                               //     color: Color(0xFF24a7ad), width: 3),
//                               activeColor: Colors.white,
//                               inactiveColor: Colors.white,
//                               activeToggleColor: Color(0xFF24a7ad),
//                               inactiveToggleColor: Colors.grey,
//                               onToggle: (val) {
//                                 setState(() {
//                                   status = val;
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(width: defaultPadding),
//                           InkWell(
//                               onTap: () {},
//                               child: SvgPicture.asset(
//                                   "assets/admin/Config/View.svg")),
//                         ],
//                       )
//                     : Text('$data', style: textStyle),
//       );
//     }).toList();
