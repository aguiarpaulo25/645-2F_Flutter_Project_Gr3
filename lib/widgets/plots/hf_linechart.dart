import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HFLineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  HFLineChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LineChart(
      LineChartData(
          minX: 0, //min and max values of the chart
          maxX: 11,
          minY: 0,
          maxY: 6,

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
                spots: [//different points in the line chart
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(4.9, 5),
                  FlSpot(6.8, 2.5),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4)
                ],
                isCurved: true, //curves the line
                colors: gradientColors, //makes the line gradient
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