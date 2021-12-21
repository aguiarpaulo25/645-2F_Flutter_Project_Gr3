import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  FirebaseService();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection("users");

  final String todaysDate = DateTime.now().day.toString() +
      DateTime.now().month.toString() +
      DateTime.now().year.toString();

  CollectionReference getUserCollection() {
    return _usercollection;
  }

  Future<List<dynamic>> getAll() async {
    var data = [];
    try {
      await _usercollection
          .doc(userId)
          .collection("days")
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if(doc.id == todaysDate) {
            List list = doc["data"] as List;
            for (var element in list) {
              data.add(element);
            }
          }
        }
      });
    } catch (e) {
      debugPrintStack();
      return data;
    }

    return data;
  }

  Future<List<dynamic>> getFrequency() async {
    var data = [];
    try {
      await _usercollection
          .doc(userId)
          .collection("days")
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.id == todaysDate) {
            List list = doc["data"] as List;
            for (var element in list) {
              data.add(element["frequency"]);
            }
          }
        }
      });
    } catch (e) {
      debugPrintStack();
      return data;
    }

    return data;
  }

  Future<List<dynamic>> getTemperature() async {
    var data = [];
    try {
      await _usercollection
          .doc(userId)
          .collection("days")
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.id == todaysDate) {
            List list = doc["data"] as List;
            for (var element in list) {
              data.add(element["temperature"]);
            }
          }
        }
      });
    } catch (e) {
      debugPrintStack();
      return data;
    }

    return data;
  }

  Future<List<dynamic>> getHumidity() async {
    var data = [];
    try {
      await _usercollection
          .doc(userId)
          .collection("days")
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.id == todaysDate) {
            List list = doc["data"] as List;
            for (var element in list) {
              data.add(element["humidity"]);
            }
          }
        }
      });
    } catch (e) {
      debugPrintStack();
      return data;
    }

    return data;
  }

  Future<List<dynamic>> getTime() async {
    var data = [];
    try {
      await _usercollection
          .doc(userId)
          .collection("days")
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.id == todaysDate) {
            List list = doc["data"] as List;
            for (var element in list) {
              data.add(element["time"]);
            }
          }
        }
      });
    } catch (e) {
      debugPrintStack();
      return data;
    }

    return data;
  }

  Future getLastestFrequency() async {
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == todaysDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element['frequency']);
          }
        }
      }
    });

    try {
      return data[data.length - 1];
    } catch (e) {
      return 0;
    }
  }

  Future getLastestTemperature() async {
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == todaysDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element['temperature']);
          }
        }
      }
    });
    try {
      return data[data.length - 1];
    } catch (e) {
      return 0;
    }
  }

  Future getLastestHumidity() async {
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == todaysDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element['humidity']);
          }
        }
      }
    });
    try {
      return data[data.length - 1];
    } catch (e) {
      return 0;
    }
  }
}
