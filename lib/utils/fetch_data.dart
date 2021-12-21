import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:http/http.dart' as http;

class FetchData {

  CollectionReference userRef = FirebaseService().getUserCollection();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final String todaysDate = DateTime.now().day.toString() +
      DateTime.now().month.toString() +
      DateTime.now().year.toString();

  late Timer _timer;

  Future addData() async {
    List<dynamic> measures;

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      measures = await fetchShirtMeasures();
      var allData;
      int length = 0;
      try {
        length = (await FirebaseService().getHumidity().timeout(const Duration(milliseconds: 1000))).length;
        allData = (await FirebaseService().getAll().timeout(const Duration(seconds : 1)));
        allData.add({"time": measures[0], "temperature": measures[3], "humidity": measures[2], "frequency": measures[1]});

      } on TimeoutException catch (error) {
        debugPrintStack();
        length = 0;
        allData = List.empty();
      }

      userRef.doc(userId).collection("days").doc(todaysDate).set({"data": FieldValue.arrayUnion(allData)}
      );
    });
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
