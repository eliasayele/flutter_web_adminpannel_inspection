import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/models/Summary.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class Chart extends StatelessWidget {
  const Chart(
    this.summary, {
    Key? key,
  }) : super(key: key);
  final Summary summary;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
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
        SplineSeries<SalesData, DateTime>(
            dataSource: <SalesData>[
              //SalesData(summary.data.[2]., 28),
              SalesData(DateTime(2018, 9, 7, 17, 30), 10),
              SalesData(DateTime(2019, 9, 7, 17, 30), 55),
              SalesData(DateTime(2020, 9, 7, 17, 30), 15),
              SalesData(DateTime(2021, 9, 7, 17, 30), 50)
            ],
            pointColorMapper: (SalesData sales, _) => Colors.deepOrangeAccent,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales),
        SplineSeries<SalesData, DateTime>(
            dataSource: <SalesData>[
              SalesData(DateTime(2017, 9, 7, 17, 30), 90),
              SalesData(DateTime(2018, 9, 7, 17, 30), 70),
              SalesData(DateTime(2019, 9, 7, 17, 30), 35),
              SalesData(DateTime(2020, 9, 7, 17, 30), 40),
              SalesData(DateTime(2021, 9, 7, 17, 30), 30)
            ],
            pointColorMapper: (SalesData sales, _) =>
                Colors.blueGrey.withOpacity(0.5),
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales)
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
