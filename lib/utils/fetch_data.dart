import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:http/http.dart' as http;

class FetchData {

  CollectionReference userRef = FirebaseService().getUserCollection();

  late Timer _timer;

  Future addData() async {
    List<String> measures;
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {


      measures = await fetchShirtMeasures();
      String time = measures[0];
      String frequency = measures[1];
      String temperature = measures[2];
      String humidity = measures[3];
      userRef.doc("AQxXZP8p4IdScUnQhLFLK9B3QrA2").set({"29112021":{
        "time":time,
        "frequence" : frequency,
        "temperature" : temperature,
        "humidity" : humidity
      }}
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
      return _measures;
    }

    return _measures;
  }


}
