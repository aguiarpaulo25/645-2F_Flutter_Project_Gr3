import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/plots/hf_linechart.dart';

class PlotContainerHF extends StatelessWidget {
  const PlotContainerHF({Key? key}) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: HFLineChartWidget(),
        ),
      ),
    );
  }

}