import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/firebase_service.dart';

class TEMPLineChartAvgWidget extends StatefulWidget {
  const TEMPLineChartAvgWidget({Key? key}) : super(key: key);

  @override
  _TEMPLineChartAvgWidgetState createState() => _TEMPLineChartAvgWidgetState();
}

class _TEMPLineChartAvgWidgetState extends State<TEMPLineChartAvgWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final FirebaseService _service = FirebaseService();
  var data = [];
  var showAvg = false;
  var averages = [];

  Future<void> updateData() async {
    _service.getTemperature().then((value) => setState(() {
      data.addAll(value);
    }));

    _service.getAllTemperatureAverages().then((value) => setState(() {
      averages.addAll(value);
    }));
  }

  List<FlSpot>? _averageGraphSpots() {
    List<FlSpot> list = [];

    for (int i = 0; i < averages.length; i++) {
      list.add(FlSpot(i.toDouble(), averages[i]));
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  LineChartData avgData() {
    return LineChartData(
        minX: 0,
        maxX: averages.length.toDouble() - 1,
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
            return Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 0.0, top: 6, bottom: 12),
              child: LineChart(avgData()),
            );
          }
        });
  }
}
