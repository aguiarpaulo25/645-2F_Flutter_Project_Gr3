import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:http/http.dart' as http;

class FetchData {
  CollectionReference userRef = FirebaseService().getUserCollection();

  static bool timerStarted = false;

  static double refreshRate = 10;

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  late String todaysDate;

  void initTodaysDate() {
    var formattedDate = "";
    if (DateTime.now().day < 10) {
      if (DateTime.now().month < 10) {
        formattedDate = "0" +
            DateTime.now().day.toString() +
            "0" +
            DateTime.now().month.toString() +
            DateTime.now().year.toString();
      } else {
        formattedDate = "0" +
            DateTime.now().day.toString() +
            DateTime.now().month.toString() +
            DateTime.now().year.toString();
      }
    } else {
      if (DateTime.now().month < 10) {
        formattedDate = DateTime.now().day.toString() +
            "0" +
            DateTime.now().month.toString() +
            DateTime.now().year.toString();
      } else {
        formattedDate = DateTime.now().day.toString() +
            DateTime.now().month.toString() +
            DateTime.now().year.toString();
      }
    }

    todaysDate = formattedDate;
  }

  static late Timer _timer;

  restartTimer(double refreshRateT) {
    refreshRate = refreshRateT;
    _timer.cancel();
    timerStarted = false;
    addData();
  }

  Future addData() async {
    List<dynamic> measures;
    initTodaysDate();

    if (!timerStarted) {
      _timer =
          Timer.periodic(Duration(seconds: refreshRate.toInt()), (timer) async {
        measures = await fetchShirtMeasures();
        timerStarted = true;
        var allData;
        try {
          allData = (await FirebaseService()
              .getAll()
              .timeout(const Duration(seconds: 1)));
          allData.add({
            "time": measures[0],
            "temperature": measures[3],
            "humidity": measures[2],
            "frequency": measures[1]
          });
        } on TimeoutException catch (error) {
          debugPrintStack();
          allData = List.empty();
        }

        userRef
            .doc(userId)
            .collection("days")
            .doc(todaysDate)
            .set({"data": FieldValue.arrayUnion(allData)});
      });
    }
  }

  Future<List<String>> fetchShirtMeasures() async {
    List<String> _measures = [];

    try {
      // TODO : Replace here by real ip 192.168.4.2
      final response =
          await http.get(Uri.parse('https://www.danielabgottspon.ch/'));

      if (response.statusCode == 200) {
        _measures = response.body.split(" ");
      }
    } on SocketException {
      debugPrint("Ex");
    }

    return _measures;
  }
}
