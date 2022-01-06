import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseService();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection("users");

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

  CollectionReference getUserCollection() {
    return _usercollection;
  }

  String getUserId() {
    return userId;
  }

  Future<List<dynamic>> getAll() async {
    initTodaysDate();
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
            data.add(element);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getFrequency() async {
    initTodaysDate();
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
            data.add(element["frequency"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getFrequencyByDate(String date) async {
    var newDate = date.replaceAll(".", "");
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == newDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element["frequency"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getTemperature() async {
    initTodaysDate();
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
            data.add(element["temperature"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getTemperatureByDate(String date) async {
    var newDate = date.replaceAll(".", "");
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == newDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element["temperature"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getHumidity() async {
    initTodaysDate();
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
            data.add(element["humidity"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getHumidityByDate(String date) async {
    var newDate = date.replaceAll(".", "");
    var data = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.id == newDate) {
          List list = doc["data"] as List;
          for (var element in list) {
            data.add(element["humidity"]);
          }
        }
      }
    });

    return data;
  }

  Future<List<dynamic>> getTime() async {
    initTodaysDate();
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
            data.add(element["time"]);
          }
        }
      }
    });

    return data;
  }

  Future getLastestFrequency() async {
    initTodaysDate();
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
    initTodaysDate();
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
    initTodaysDate();
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

  Future<List<dynamic>> getAllFrequencyAverages() async {
    initTodaysDate();
    var averages = [];
    var result = 0.0;
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        List list = doc["data"] as List;
        result = 0.0;
        for (var element in list) {
          result += double.parse(element["frequency"]);
        }
        result /= list.length - 1;
        averages.add(result);
      }
    });

    return averages;
  }

  Future<List<dynamic>> getAllTemperatureAverages() async {
    initTodaysDate();
    var averages = [];
    var result = 0.0;
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        List list = doc["data"] as List;
        result = 0.0;
        for (var element in list) {
          result += double.parse(element["temperature"]);
        }
        result /= list.length - 1;
        averages.add(result);
      }
    });

    return averages;
  }

  Future<List<dynamic>> getAllHumidityAverages() async {
    initTodaysDate();
    var averages = [];
    var result = 0.0;
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        List list = doc["data"] as List;
        result = 0.0;
        for (var element in list) {
          result += double.parse(element["humidity"]);
        }
        result /= list.length - 1;
        averages.add(result);
      }
    });

    return averages;
  }

  Future<List<String>> getAllDates() async {
    initTodaysDate();
    List<String> dates = [];
    await _usercollection
        .doc(userId)
        .collection("days")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        dates.add(doc.id);
      }
    });

    return dates;
  }
}
