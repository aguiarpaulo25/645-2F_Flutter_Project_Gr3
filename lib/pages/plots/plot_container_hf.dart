import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/plots/hf_linechart.dart';
import 'package:flutter_project/widgets/plots/hf_linechart_avg.dart';

class PlotContainerHF extends StatefulWidget {
  const PlotContainerHF({Key? key}) : super(key: key);

  @override
  _PlotContainerHFState createState() => _PlotContainerHFState();
}

class _PlotContainerHFState extends State<PlotContainerHF>
    with AutomaticKeepAliveClientMixin {
  var showAvg = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showAvg ? 'Average of all data' : 'Today\'s data',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: showAvg
                    ? const Text("Current data")
                    : const Text("Average"),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
            ),
          ],
        ),
      ]),
      Card(
        margin: const EdgeInsets.fromLTRB(30, 60, 30, 30),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: showAvg
              ? const HFLineChartAvgWidget()
              : const HFLineChartWidget(),
        ),
      ),
    ]);
  }
}
