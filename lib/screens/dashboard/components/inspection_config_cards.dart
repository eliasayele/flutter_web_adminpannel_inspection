import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/models/Summary.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';
import 'chart.dart';

class ConfigurationsCard extends StatelessWidget {
  const ConfigurationsCard(
    this.summary, {
    Key? key,
  });
  final Summary summary;
  @override
  Widget build(BuildContext context) {
    var data = summary.data.vehicleTypeInspections;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultPadding * 1.5),
          Text(
            "Configurations",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Container(
            height: 366,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return TotalConfigCars(
                  summary: data[index],
                  title: data[index].vehicleType,
                  whatfor: "${data[index].total.toString()}  inspected",
                );
              },
            ),
          ),
          // TotalConfigCars(
          //   summary: summary,
          //   title: "CAR",
          //   whatfor: "${data[0].total.toString()}  inspected",
          // ),
          // TotalConfigCars(
          //   summary: summary,
          //   title: "ELECTRIC CAR",
          //   whatfor: "${data[1].total.toString()}  inspected",
          // ),
          // TotalConfigCars(
          //   summary: summary,
          //   title: "MOTOR",
          //   whatfor: "${data[2].total.toString()}  inspected",
          // ),
        ],
      ),
    );
  }
}

class TotalConfigCars extends StatelessWidget {
  TotalConfigCars({
    Key? key,
    this.dividerColor,
    required this.title,
    required this.whatfor,
    required this.summary,
  }) : super(key: key);

  final Color? dividerColor;
  final String title, whatfor;
  final VehicleTypeInspection summary;
  final TextStyle cardtstyle = TextStyle(
    color: Colors.black,
    fontSize: 11,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      decoration: BoxDecoration(color: Color(0xFFF9FAFC)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dividerColor != null)
            Container(
              height: 85,
              color: dividerColor,
              width: 3,
            ),
          SizedBox(width: defaultPadding * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(whatfor, style: cardtstyle),
            ],
          ),
          Spacer(),
          SmallChart(summary),
        ],
      ),
    );
  }
}

class InspectionsCard extends StatelessWidget {
  const InspectionsCard(
    this.summary, {
    Key? key,
  });
  final Summary summary;
  @override
  Widget build(BuildContext context) {
    var data = summary.data.inspections;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultPadding * 1.5),
          Text(
            "Inspection",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          TotalCards(
            summary: summary,
            amout: data.currentTotal.toString(),
            dividerColor: Colors.blue,
            whatfor: "vehicle inspected",
          ),
          TotalCards(
            summary: summary,
            amout: data.currentPassed.toString(),
            dividerColor: Colors.yellow[300]!,
            whatfor: "passed",
          ),
          TotalCards(
            summary: summary,
            amout: data.currentFailed.toString(),
            dividerColor: Colors.redAccent,
            whatfor: "failed",
          ),
        ],
      ),
    );
  }
}

class TotalCards extends StatelessWidget {
  TotalCards({
    Key? key,
    required this.summary,
    this.dividerColor,
    required this.amout,
    required this.whatfor,
  }) : super(key: key);
  final Summary summary;
  final Color? dividerColor;
  final String amout, whatfor;
  final TextStyle cardtstyle = TextStyle(
    color: Colors.black,
    fontSize: 11,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      decoration: BoxDecoration(color: Color(0xFFF9FAFC)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dividerColor != null)
            Container(
              height: 85,
              color: dividerColor,
              width: 3,
            ),
          SizedBox(width: defaultPadding * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(amout,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(whatfor, style: cardtstyle),
            ],
          ),
          MiniChart(summary),
        ],
      ),
    );
  }
}

class MiniChart extends StatefulWidget {
  MiniChart(this.summary, {Key? key}) : super(key: key);
  final Summary summary;

  @override
  _MiniChartState createState() => _MiniChartState();
}

class _MiniChartState extends State<MiniChart> {
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

  // late List<GraphData> graphData = [GraphData(DateTime(2012, 5, 0, 0, 30), 45)];
  //
  // // List<int>? datamonth;
  //
  // Future getMonthData() async {
  //   for (var i = 0; i < widget.summary.monthlyInspections.length; i++) {
  //     if (widget.summary.monthlyInspections.length != 0) {
  //       graphData = [];
  //       print(graphData.length);
  //       print(graphData.first);
  //       var monthnumber = MiniChart.months
  //               .indexOf(widget.summary.monthlyInspections[i].month) +
  //           1;
  //       graphData.add(GraphData(DateTime(2021, monthnumber, 7, 17, 30),
  //           widget.summary.monthlyInspections[i].value.toDouble()));
  //       //print(graphData.first);
  //     }
  //   }
  // }
  //
  // @override
  // void initState() {
  //   getMonthData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            tickPosition: null,
            isVisible: false,
            axisLine: AxisLine(width: 0),
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            //labelPosition: ChartDataLabelPosition.inside,
          ),
          primaryYAxis: NumericAxis(
              isVisible: false,
              majorTickLines: MajorTickLines(width: 0),
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              //Hide the gridlines of y-axis
              majorGridLines: MajorGridLines(width: 0),
              //Hide the axis line of y-axis
              axisLine: AxisLine(width: 0)),
          series: <ChartSeries>[
            // Renders spline chart
            SplineSeries<SalesData, DateTime>(
              dataSource: <SalesData>[
                SalesData(DateTime(2018, 9, 7, 17, 30), 10),
                SalesData(DateTime(2019, 9, 7, 17, 30), 55),
                SalesData(DateTime(2020, 9, 7, 17, 30), 15),
                SalesData(DateTime(2021, 9, 7, 17, 30), 50)
              ],
              pointColorMapper: (SalesData sales, _) => Colors.deepOrangeAccent,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
            ),
          ],
        ),
      ),
    );
  }
}

class SmallChart extends StatefulWidget {
  SmallChart(this.summary, {Key? key}) : super(key: key);
  final VehicleTypeInspection summary;

  @override
  _SmallChartState createState() => _SmallChartState();
}

class _SmallChartState extends State<SmallChart> {
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
  late List<GraphData> graphData = [GraphData(DateTime(2021, 5, 1, 1, 30), 45)];

  List<int>? datamonth;
  Future getMonthData() async {
    for (var i = 0; i < widget.summary.monthlyInspections.length; i++) {
      if (widget.summary.monthlyInspections.length != 0) {
        graphData = [];
        print(graphData.length);
        //print(graphData.first);
        var monthnumber =
            months.indexOf(widget.summary.monthlyInspections[i].month) + 1;
        print("///////");
        print(monthnumber);
        graphData.add(GraphData(DateTime(2021, monthnumber, 7, 17, 30),
            widget.summary.monthlyInspections[i].value.toDouble()));
        print("//// this one second thing");
        print(widget.summary.monthlyInspections[i].value);
        graphData.add(GraphData(DateTime(2018, 9, 7, 17, 30), 10));
        // graphData.add(GraphData(DateTime(2019, 9, 7, 17, 30), 250));
        // graphData.add(GraphData(DateTime(2020, 9, 7, 17, 30), 15));
        // graphData.add(GraphData(DateTime(2021, 9, 7, 17, 30), 300));
        //print(graphData.first);
      }
    }
  }

  @override
  void initState() {
    getMonthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.months,
            interval: 2,
            tickPosition: null,
            isVisible: false,
            axisLine: AxisLine(width: 0),
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            //labelPosition: ChartDataLabelPosition.inside,
          ),
          primaryYAxis: NumericAxis(
              //interval: 10,
              isVisible: false,
              majorTickLines: MajorTickLines(width: 0),
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              //Hide the gridlines of y-axis
              majorGridLines: MajorGridLines(width: 0),
              //Hide the axis line of y-axis
              axisLine: AxisLine(width: 0)),
          series: <ChartSeries>[
            SplineSeries<GraphData, DateTime>(
              dataSource: graphData,
              // for (int i = 0; i < graphData.length; i++)
              //   {
              //     graphData[i].,
              //   }
              // SalesData(DateTime(2018, 9, 7, 17, 30), 10),
              // SalesData(DateTime(2019, 9, 7, 17, 30), 250),
              // SalesData(DateTime(2020, 9, 7, 17, 30), 15),
              // SalesData(DateTime(2021, 9, 7, 17, 30), 300)
              // ],
              pointColorMapper: (GraphData data, _) => Colors.lightGreen,
              xValueMapper: (GraphData data, _) => data.year,
              yValueMapper: (GraphData data, _) => data.sales,
            ),
          ],
        ),
      ),
    );
  }
}

class GraphData {
  GraphData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
