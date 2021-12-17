import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_project/pages/menu/navdrawer.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:flutter_project/widgets/current_info_card.dart';

class CurrentInfo extends StatefulWidget {
  const CurrentInfo({Key? key}) : super(key: key);

  @override
  _CurrentInfoState createState() => _CurrentInfoState();
}

class _CurrentInfoState extends State<CurrentInfo> {
  final FirebaseService _service = FirebaseService();
  var frequency;
  var temperature;
  var humidity;

  void updateData() {
    _service.getLastestFrequency().then((value) => {
      setState(() {
        try {
          frequency = value;
        }
        catch (e)
        {
          debugPrint("Fetching frequency failed");
        }

      })
    });

    _service.getLastestTemperature().then((value) => {
      setState(() {
        try {
          temperature = value;
        }
        catch (e)
        {
          debugPrint("Fetching temperature failed");
        }
      })
    });

    _service.getLastestHumidity().then((value) => {
      setState(() {
        try {
          humidity = value;
        }
        catch (e)
        {
          debugPrint("Fetching humidity failed");
        }
      })
    });
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Connected t-shirt"),
      ),
      body: Column(children: [
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        Text("Hello User, here is your current info",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                color: Theme.of(context).primaryColorDark)),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseService().getUserCollection().snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const LinearProgressIndicator();

                  return ListView(itemExtent: 190.0, children: <Widget>[
                    CurrentInfoCard(
                        cardTitle: 'Heart Frequency',
                        cardIcon: Icons.favorite_border_outlined,
                        connectionToDb: frequency +
                            " Hz",
                        cardColor: Theme.of(context).primaryColorLight),

                    CurrentInfoCard(
                        cardTitle: 'Temperature',
                        cardIcon:Icons.thermostat_outlined,
                        connectionToDb: temperature +
                            " °C",
                        cardColor: Theme.of(context).cardColor),

                    CurrentInfoCard(
                        cardTitle: 'Humidity',
                        cardIcon:Icons.opacity_outlined,
                        connectionToDb: humidity +
                            " %",
                        cardColor: Theme.of(context).secondaryHeaderColor),
                  ]);
                }))
      ]),
      drawer: const NavDrawer(),
    );
  }
}
