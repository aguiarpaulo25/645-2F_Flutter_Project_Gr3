import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/firebase_service.dart';

class HUMLineChartWidget extends StatefulWidget {
  const HUMLineChartWidget({Key? key}) : super(key: key);

  @override
  _HUMLineChartWidgetState createState() => _HUMLineChartWidgetState();
}

class _HUMLineChartWidgetState extends State<HUMLineChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final FirebaseService _service = FirebaseService();
  var data = [];
  var timeList = [];
  var convertedTimeList = [];
  var showAvg = false;
  var averages = [];

  Future<void> updateData() async {
    _service.getHumidity().then((value) => setState(() {
          data.addAll(value);
        }));

    _service.getTime().then((value) => setState(() {
      timeList.addAll(value);
      convertedTimeList = convertTimeToDouble()!;
    }));

    _service.getAllHumidityAverages().then((value) => setState(() {
      averages.addAll(value);
    }));
  }

  List<FlSpot>? _mainGraphSpots() {
    List<FlSpot> list = [];

    for (int i = 0; i < data.length - 1; i++) {
      list.add(FlSpot(convertedTimeList[i], double.parse(data[i])));
    }

    return list;
  }

  List<FlSpot>? _averageGraphSpots() {
    List<FlSpot> list = [];

    for (int i = 0; i < averages.length; i++) {
      list.add(FlSpot(i.toDouble(), averages[i]));
    }

    return list;
  }

  List<double>? convertTimeToDouble() {
    List<double> list = [];

    for(int i = 0; i < timeList.length - 1; i++) {
      String temp = timeList[i].replaceAll(":", "");
      double convertedTime = double.parse(temp.substring(0, 2)) + double.parse(temp.substring(2, 4)) / 60;
      list.add(convertedTime);
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
        minY: -10,
        maxY: 45,
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

  LineChartData avgData() {
    return LineChartData(
        minX: 0,
        maxX: averages.length.toDouble() - 1,
        minY: -10,
        maxY: 45,
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
              spots: _averageGraphSpots(),
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
    return StreamBuilder<QuerySnapshot>(
        stream: _service.getUserCollection().snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (data.isEmpty) {
            return const LinearProgressIndicator();
          } else {
            return Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      showAvg ? 'Average of all data' : 'Today\'s data',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      showAvg ? avgData() : mainData(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 35,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'avg',
                      style: TextStyle(
                          fontSize: 12,
                          color: showAvg
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
