import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/plots/hf_linechart.dart';

class PlotContainerHF extends StatefulWidget {
  const PlotContainerHF({Key? key}) : super(key: key);

  @override
  _PlotContainerHFState createState() => _PlotContainerHFState();
}

class _PlotContainerHFState extends State<PlotContainerHF> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          child: HFLineChartWidget(),
        ),
      ),
    );
  }
}