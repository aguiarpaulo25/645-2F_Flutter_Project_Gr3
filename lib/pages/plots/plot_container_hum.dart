import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:flutter_project/utils/theme_colors.dart';
import 'package:flutter_project/widgets/plots/hum_linechart.dart';
import 'package:flutter_project/widgets/plots/hum_linechart_avg.dart';

class PlotContainerTEMP extends StatefulWidget {
  const PlotContainerTEMP({Key? key}) : super(key: key);

  @override
  _PlotContainerTEMPState createState() => _PlotContainerTEMPState();
}

class _PlotContainerTEMPState extends State<PlotContainerTEMP>
    with AutomaticKeepAliveClientMixin {
  final _service = FirebaseService();
  var showAvg = false;
  List<String> dates = [];
  List<String> formattedDates = [];
  String chosenDate = "";

  String initTodaysDate() {
    var formattedDate = "";
    if (DateTime.now().day < 10) {
      if (DateTime.now().month < 10) {
        formattedDate = "0" +
            DateTime.now().day.toString() +
            ".0" +
            DateTime.now().month.toString() +
            "." +
            DateTime.now().year.toString();
      } else {
        formattedDate = "0" +
            DateTime.now().day.toString() +
            "." +
            DateTime.now().month.toString() +
            "." +
            DateTime.now().year.toString();
      }
    } else {
      if (DateTime.now().month < 10) {
        formattedDate = DateTime.now().day.toString() +
            ".0" +
            DateTime.now().month.toString() +
            "." +
            DateTime.now().year.toString();
      } else {
        formattedDate = DateTime.now().day.toString() +
            "." +
            DateTime.now().month.toString() +
            "." +
            DateTime.now().year.toString();
      }
    }

    return formattedDate;
  }

  void formatDate() {
    for (int i = 0; i < dates.length; i++) {
      formattedDates.add(dates[i].substring(0, 2) +
          "." +
          dates[i].substring(2, 4) +
          "." +
          dates[i].substring(4));
    }
  }

  Future<void> updateData() async {
    _service.getAllDates().then((value) => setState(() {
          dates = [];
          dates.addAll(value);
        }));
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (chosenDate == "") {
      chosenDate = initTodaysDate();
    }
    updateData();
    formattedDates = [];
    formatDate();
    super.build(context);
    return Stack(children: <Widget>[
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showAvg ? "AverageAllData".tr() : "TodayData".tr(),
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
                    ? const Text("CurrentData").tr()
                    : const Text("Average").tr(),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton<String>(
                value: chosenDate,
                elevation: 10,
                underline: Container(
                  height: 2,
                  color: ThemeColors.lightTheme.primaryColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    chosenDate = newValue!;
                  });
                },
                items: formattedDates
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
              ? const HUMLineChartAvgWidget()
              : HUMLineChartWidget(chosenDate),
        ),
      ),
    ]);
  }
}
