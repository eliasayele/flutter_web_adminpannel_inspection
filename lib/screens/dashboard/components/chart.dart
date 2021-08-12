import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/models/Summary.dart';
import 'package:inspection_admin/screens/dashboard/components/inspection_config_cards.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class Chart extends StatefulWidget {
  Chart(
    this.summary, {
    Key? key,
  }) : super(key: key);
  final Summary summary;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<GraphData> graphData = [GraphData(DateTime(2021, 5, 1, 1, 30), 45)];
  static const months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  List<int>? datamonth;

  Future getMonthData() async {
    for (var i = 0; i < widget.summary.data.totalRevenue.monthly.length; i++) {
      graphData = [];
      print(graphData.length);
      //print(graphData.first);
      var monthnumber =
          months.indexOf(widget.summary.data.totalRevenue.monthly[i].month) + 1;
      print("///////");
      print(monthnumber);
      graphData.add(GraphData(DateTime(2021, monthnumber, 7, 17, 30),
          widget.summary.data.totalRevenue.monthly[i].value.toDouble()));
      print("//// this one second thing from revenu");
      print(widget.summary.data.totalRevenue.monthly[i].value);
      graphData.add(GraphData(DateTime(2021, 3, 7, 17, 30), 100));
      // graphData.add(GraphData(DateTime(2021, 3, 7, 17, 30), 50));
      //graphData.add(GraphData(DateTime(2021, 4, 7, 17, 30), 200));
      // graphData.add(GraphData(DateTime(2021, 5, 7, 17, 30), 30));
      //print(graphData.first);

    }
  }

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: "total revenue",
    );
    getMonthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      plotAreaBorderWidth: 0,
      tooltipBehavior: _tooltipBehavior,
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.months,
        interval: 1,
        dateFormat: DateFormat.yMMMM(),
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w100),
        axisLine: AxisLine(width: 0.5),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
          // isVisible: false,
          //Hide the gridlines of y-axis
          // majorGridLines: MajorGridLines(width: 0),
          //Hide the axis line of y-axis
          axisLine: AxisLine(width: 0)),
      series: <ChartSeries>[
        // Renders spline chart
        SplineSeries<GraphData, DateTime>(
            enableTooltip: true,
            dataSource: graphData,
            pointColorMapper: (GraphData sales, _) => Colors.deepOrangeAccent,
            xValueMapper: (GraphData sales, _) => sales.year,
            yValueMapper: (GraphData sales, _) => sales.sales),
      ],
      backgroundColor: Colors.white,
      title: ChartTitle(
          text: "Revenue",
          textStyle: TextStyle(color: Colors.black),
          alignment: ChartAlignment.near),
    );
  }
}

List<PieChartSectionData> pieChartSelectionDatas = [
  PieChartSectionData(
    value: 15,
    color: Color(0xFF26E5FF),
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    value: 10,
    color: Color(0xFFFFCF26),
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    value: 15,
    color: Color(0xFFEE2727),
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    value: 20,
    color: primaryColor.withOpacity(0.1),
    showTitle: false,
    radius: 13,
  ),
  PieChartSectionData(
    value: 20,
    color: primaryColor,
    showTitle: false,
    radius: 25,
  ),
];
