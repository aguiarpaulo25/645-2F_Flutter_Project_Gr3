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

  Future<void> updateData() async {
    _service.getHumidity().then((value) => setState(() {
          data.addAll(value);
        }));
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _service.getUserCollection().snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (data.isEmpty) {
            return const LinearProgressIndicator();
          } else {
            return LineChart(LineChartData(
                //min and max values of the chart
                minX: 0,
                maxX: 5,
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
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xffe6e6e6), width: 1),
                ),
                lineBarsData: [
                  // Draws the line
                  LineChartBarData(
                      spots: [
                        //different points in the line chart
                        FlSpot(0.0, double.parse(data[0])),
                        FlSpot(1.0, double.parse(data[1])),
                        FlSpot(2.0, double.parse(data[2])),
                        FlSpot(3.0, double.parse(data[3])),
                        FlSpot(4.0, double.parse(data[4])),
                        FlSpot(5.0, double.parse(data[5]))
                      ],
                      isCurved: true,
                      //curves the line
                      colors: gradientColors,
                      //makes the line gradient
                      barWidth: 5,
                      //dotData: FlDotData(show: false), //removes the dots in the line
                      belowBarData: BarAreaData(
                        //adds the color under the curve
                        show: true,
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ))
                ]));
          }
        });
  }
}
