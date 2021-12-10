import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/plots/hum_linechart.dart';

class PlotContainerHUM extends StatefulWidget {
  const PlotContainerHUM({Key? key}) : super(key: key);

  @override
  _PlotContainerHUMState createState() => _PlotContainerHUMState();
}

class _PlotContainerHUMState extends State<PlotContainerHUM> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.all(30),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: HUMLineChartWidget(),
        ),
      ),
    );
  }
}