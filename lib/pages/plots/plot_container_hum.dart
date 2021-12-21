import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/plots/hum_linechart.dart';

class PlotContainerTEMP extends StatefulWidget {
  const PlotContainerTEMP({Key? key}) : super(key: key);

  @override
  _PlotContainerTEMPState createState() => _PlotContainerTEMPState();
}

class _PlotContainerTEMPState extends State<PlotContainerTEMP> with AutomaticKeepAliveClientMixin {

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
          child: HUMLineChartWidget(),
        ),
      ),
    );
  }
}