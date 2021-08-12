import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/models/Summary.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';

const months = <String>[
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
  final TextStyle cardtstyle = TextStyle(color: Colors.black, fontSize: 11);

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

class InspectionsCard extends StatefulWidget {
  const InspectionsCard(
    this.summary, {
    Key? key,
  });
  final Summary summary;

  @override
  _InspectionsCardState createState() => _InspectionsCardState();
}

class _InspectionsCardState extends State<InspectionsCard> {
  @override
  Widget build(BuildContext context) {
    var data = widget.summary.data.inspections;
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
            summary: widget.summary,
            amout: data.currentTotal.toString(),
            dividerColor: Colors.blue,
            whatfor: "vehicle inspected",
            identity: "total",
          ),
          TotalCards(
            summary: widget.summary,
            amout: data.currentPassed.toString(),
            dividerColor: Colors.yellow[300]!,
            whatfor: "passed",
            identity: "passed",
          ),
          TotalCards(
            summary: widget.summary,
            amout: data.currentFailed.toString(),
            dividerColor: Colors.redAccent,
            whatfor: "failed",
            identity: "failed",
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
    required this.identity,
  }) : super(key: key);
  final Summary summary;
  final Color? dividerColor;
  final String amout, whatfor, identity;
  final TextStyle cardtstyle = TextStyle(color: Colors.black, fontSize: 11);
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
              Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    whatfor,
                    style: cardtstyle,
                  )),
            ],
          ),
          MiniChart(summary, identity, dividerColor!),
        ],
      ),
    );
  }
}

class MiniChart extends StatefulWidget {
  MiniChart(this.summary, this.identity, this.linecolor);
  final Summary summary;
  final String identity;
  final Color linecolor;

  @override
  _MiniChartState createState() => _MiniChartState();
}

class _MiniChartState extends State<MiniChart> {
  late List<GraphData> toatalData = [GraphData(DateTime(2021, 5), 45)];
  late List<GraphData> passedData = [GraphData(DateTime(2021, 5), 45)];
  late List<GraphData> failedData = [GraphData(DateTime(2021, 5), 45)];

  Future gettotaltData() async {
    for (var i = 0; i < widget.summary.data.inspections.monthly.length; i++) {
      toatalData = [];
      print(toatalData.length);
      //print(graphData.first);
      var monthnumber =
          months.indexOf(widget.summary.data.inspections.monthly[i].month) + 1;
      print("///////");
      print(monthnumber);
      toatalData.add(GraphData(DateTime(2021, monthnumber),
          widget.summary.data.inspections.monthly[i].value.toDouble()));
      print("//// this one second thing");
      print(widget.summary.data.inspections.monthly[i].value);
      toatalData.add(GraphData(DateTime(2020, 9), 10));
      // graphData.add(GraphData(DateTime(2019, 9, 7, 17, 30), 250));
      // graphData.add(GraphData(DateTime(2020, 9, 7, 17, 30), 15));
      // graphData.add(GraphData(DateTime(2021, 9, 7, 17, 30), 300));
      //print(graphData.first);
    }
  }

  Future getpassedData() async {
    for (var i = 0;
        i < widget.summary.data.monthlyPassedInspections.length;
        i++) {
      if (widget.summary.data.monthlyPassedInspections.length != 0) {
        passedData = [];
        print(passedData.length);
        //print(graphData.first);
        var monthnumber = months.indexOf(
                widget.summary.data.monthlyPassedInspections[i].month) +
            1;
        print("///////");
        print(monthnumber);
        passedData.add(GraphData(DateTime(2021, monthnumber),
            widget.summary.data.monthlyPassedInspections[i].value.toDouble()));
        print("//// this one second thing");
        print(widget.summary.data.monthlyPassedInspections[i].value);
        passedData.add(GraphData(DateTime(2020, 9), 10));
        // graphData.add(GraphData(DateTime(2019, 9, 7, 17, 30), 250));
        // graphData.add(GraphData(DateTime(2020, 9, 7, 17, 30), 15));
        // graphData.add(GraphData(DateTime(2021, 9, 7, 17, 30), 300));
        //print(graphData.first);
      }
    }
  }

  Future getfailedData() async {
    for (var i = 0;
        i < widget.summary.data.monthlyFailedInspections.length;
        i++) {
      if (widget.summary.data.monthlyFailedInspections.length != 0) {
        failedData = [];
        print(failedData.length);
        //print(graphData.first);
        var monthnumber = months.indexOf(
                widget.summary.data.monthlyFailedInspections[i].month) +
            1;
        print("///////");
        print(monthnumber);
        failedData.add(GraphData(DateTime(2021, monthnumber),
            widget.summary.data.monthlyFailedInspections[i].value.toDouble()));
        print("//// this one failed data thing");
        print(widget.summary.data.monthlyFailedInspections[i].value);
        failedData.add(GraphData(DateTime(2020, 9), 350));
        // graphData.add(GraphData(DateTime(2019, 9, 7, 17, 30), 250));
        //  graphData.add(GraphData(DateTime(2020, 9, 7, 17, 30), 15));
        // graphData.add(GraphData(DateTime(2021, 9, 7, 17, 30), 300));
        //print(graphData.first);
      }
    }
  }

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: widget.identity == "total"
          ? "total inspected"
          : widget.identity == "passed"
              ? "total passed"
              : " total failed",
      // builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
      //     int seriesIndex) {
      //   return Container(
      //     width: 100,
      //     height: 120,
      //     margin: EdgeInsets.all(5),
      //     //padding: EdgeInsets.all(5),
      //     child: Column(
      //       children: [
      //         Text(widget.identity == "total"
      //             ? "total passed"
      //             : widget.identity == "passed"
      //                 ? "total passed"
      //                 : " total failed"),
      //         Divider(
      //           color: Colors.white,
      //         ),
      //         Text('${series.toString()}'),
      //       ],
      //     ),
      //   );
      // }
    );
    getfailedData();
    getpassedData();
    gettotaltData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.months,
            interval: 1,
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
            SplineSeries<GraphData, DateTime>(
              enableTooltip: true,
              dataSource: widget.identity == "total"
                  ? toatalData
                  : widget.identity == "passed"
                      ? passedData
                      : failedData,
              pointColorMapper: (GraphData sales, _) => widget.linecolor,
              xValueMapper: (GraphData sales, _) => sales.year,
              yValueMapper: (GraphData sales, _) => sales.sales,
            ),
          ],
        ),
      ),
    );
  }
}

class SmallChart extends StatefulWidget {
  SmallChart(
    this.summary,
  );
  final VehicleTypeInspection summary;
  // final Color lineColor;

  @override
  _SmallChartState createState() => _SmallChartState();
}

class _SmallChartState extends State<SmallChart> {
  late List<GraphData> graphData = [GraphData(DateTime(2021, 5, 1, 1, 30), 45)];

  late TooltipBehavior _tooltipBehavior;

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
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: "total inspected",
    );
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
          tooltipBehavior: _tooltipBehavior,
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
              enableTooltip: true,
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
