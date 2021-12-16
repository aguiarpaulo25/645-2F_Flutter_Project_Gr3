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

  late Timer _timer;

  Future addData() async {
    List<dynamic> measures;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {

      
      measures = await fetchShirtMeasures();
      String time = measures[0];
      int frequency = int.parse(measures[1]);
      int temperature = int.parse(measures[2]);
      int humidity = int.parse(measures[3]);

      userRef.doc(userId).set({(DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString()): [{
        "time":time,
        "frequency" : frequency,
        "temperature" : temperature,
        "humidity" : humidity
      }]}
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
