import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/firebase_service.dart';

class TEMPLineChartWidget extends StatefulWidget {
  const TEMPLineChartWidget({Key? key}) : super(key: key);

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

  void updateData() {
    _service.getTemperature().then((value) => {
      data = value
    });
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    return LineChart(
        LineChartData(//min and max values of the chart
            minX: 0,
            maxX: 5,
            minY: 0,
            maxY: 50,

            gridData: FlGridData( //grid
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
            lineBarsData: [ // Draws the line
              LineChartBarData(
                  spots: [ //different points in the line chart
                    FlSpot(0.0, data[0] * 1.0),
                    FlSpot(1.0, data[1] * 1.0),
                    FlSpot(2.0, data[2] * 1.0),
                    FlSpot(3.0, data[3] * 1.0),
                    FlSpot(4.0, data[4] * 1.0),
                    FlSpot(5.0, data[5] * 1.0)
                  ],
                  isCurved: true,
                  //curves the line
                  colors: gradientColors,
                  //makes the line gradient
                  barWidth: 5,
                  //dotData: FlDotData(show: false), //removes the dots in the line
                  belowBarData: BarAreaData( //adds the color under the curve
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  )
              )
            ]
        )
    );
  }

}