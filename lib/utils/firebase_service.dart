import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference _usercollection = FirebaseFirestore.instance.collection("users");

  CollectionReference getUserCollection() {
    return _usercollection;
  }

  Future<List<dynamic>> getFrequency() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc["29112021"] as List;
          for (var element in list) {
            data.add(element["frequency"]);
          }
        }
      }
    });
    return data;
  }

  Future<List<dynamic>> getTemperature() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc["29112021"] as List;
          for (var element in list) {
            data.add(element[DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString()]);
          }
        }
      }
    });
    return data;
  }

  Future<List<dynamic>> getHumidity() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc[DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString()] as List;
          for (var element in list) {
            data.add(element["humidity"]);
          }
        }
      }
    });
    return data;
  }

  Future getLastestFrequency() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc[(DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString())] as List;
          for (var element in list) {
            data.add(element["frequency"]);
          }
        }
      }
    });

    try {
      return data[data.length-1];
    }
    catch (e) {
      return 0;
    }
  }

  Future getLastestTemperature() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc[(DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString())] as List;
          for (var element in list) {
            data.add(element["temperature"]);
          }
        }
      }
    });
    try {
      return data[data.length-1];
    }
    catch (e) {
      return 0;
    }
  }

  Future getLastestHumidity() async {
    var data = <int>[];
    await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == userId) {
          List list = doc[(DateTime.now().day.toString()+DateTime.now().month.toString()+DateTime.now().year.toString())] as List;
          for (var element in list) {
            data.add(element["humidity"]);
          }
        }
      }
    });
    try {
      return data[data.length-1];
    }
    catch (e) {
      return 0;
    }
  }
}