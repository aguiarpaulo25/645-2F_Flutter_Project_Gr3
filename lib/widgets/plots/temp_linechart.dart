import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/firebase_service.dart';

class TEMPLineChartWidget extends StatefulWidget {
  var _date = "";

  TEMPLineChartWidget(String date, {Key? key}) : super(key: key) {
    _date = date;
  }

  @override
  _TEMPLineChartWidgetState createState() => _TEMPLineChartWidgetState();
}

class _TEMPLineChartWidgetState extends State<TEMPLineChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final FirebaseService _service = FirebaseService();
  var data = [];
  var timeList = [];
  var convertedTimeList = [];

  Future<void> updateData() async {
    _service.getTimeByDate(widget._date).then((value) => setState(() {
          timeList = [];
          timeList.addAll(value);
          convertedTimeList = convertTimeToDouble()!;
        }));

    _service.getTemperatureByDate(widget._date).then((value) => setState(() {
          data = [];
          data.addAll(value);
        }));
  }

  List<FlSpot>? _mainGraphSpots() {
    List<FlSpot> list = [];

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length - 1; i++) {
        list.add(FlSpot(convertedTimeList[i], double.parse(data[i])));
      }
    }

    return list;
  }

  List<double>? convertTimeToDouble() {
    List<double> list = [];

    if (timeList.isNotEmpty) {
      for (int i = 0; i < timeList.length; i++) {
        String temp = timeList[i].replaceAll(":", "");
        double convertedTime = double.parse(temp.substring(0, 2)) +
            double.parse(temp.substring(2, 4)) / 60;
        list.add(convertedTime);
      }
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  LineChartData mainData() {
    return LineChartData(
        //min and max values of the chart
        minX: 0,
        maxX: 24,
        minY: 0,
        maxY: 70,
        gridData: FlGridData(
          //grid
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xffe6e6e6),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xffe6e6e6),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xffe6e6e6), width: 1),
        ),
        lineBarsData: [
          // Draws the line
          LineChartBarData(
              spots: _mainGraphSpots(),
              isCurved: true,
              //curves the line
              colors: gradientColors,
              //makes the line gradient
              barWidth: 5,
              dotData: FlDotData(show: false),
              //removes the dots in the line
              belowBarData: BarAreaData(
                //adds the color under the curve
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    return StreamBuilder<QuerySnapshot>(
        stream: _service.getUserCollection().snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (data.isEmpty) {
            return const LinearProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 0.0, top: 6, bottom: 12),
              child: LineChart(mainData()),
            );
          }
        });
  }
}
