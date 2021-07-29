import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';
import 'chart.dart';

class ConfigurationsCard extends StatelessWidget {
  const ConfigurationsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          TotalCards(
            amout: "CAR",
            // dividerColor: Colors.blue,
            whatfor: "vehicle inspected",
          ),
          TotalCards(
            amout: "ELECTRIC CAR",
            // dividerColor: Colors.yellow[300]!,
            whatfor: "passed",
          ),
          TotalCards(
            amout: "MOTOR",
            // dividerColor: Colors.redAccent,
            whatfor: "failed",
          ),
        ],
      ),
    );
  }
}

class InspectionsCard extends StatelessWidget {
  const InspectionsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultPadding * 1.5,
          ),
          Text(
            "Inspection",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          TotalCards(
            amout: "12,050",
            dividerColor: Colors.blue,
            whatfor: "vehicle inspected",
          ),
          TotalCards(
            amout: "7,185",
            dividerColor: Colors.yellow[300]!,
            whatfor: "passed",
          ),
          TotalCards(
            amout: "4,712",
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
    this.dividerColor,
    required this.amout,
    required this.whatfor,
  }) : super(key: key);

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
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFC),
      ),
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
              Text(
                whatfor,
                style: cardtstyle,
              ),
            ],
          ),
          MiniChart(),
        ],
      ),
    );
  }
}

class MiniChart extends StatelessWidget {
  const MiniChart({Key? key}) : super(key: key);

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
                SalesData(DateTime(2017, 9, 7, 17, 30), 28),
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
