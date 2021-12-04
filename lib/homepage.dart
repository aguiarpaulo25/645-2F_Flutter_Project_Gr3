import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_project/navdrawer.dart';
import 'package:flutter_project/theme_color.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListState();
  }

}

class _ListState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connected t-shirt"),
      ),
      body: Column(
          children: [
            const Text("Welcome User",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 40.0)),
            Expanded(
              child:
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("/User/29.11.2021/tshirt").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const LinearProgressIndicator();
                  return ListView(
                      itemExtent: 200.0,
                      children: <Widget> [
                        Card(
                            color: SecondaryColor,
                            child: ListTile(
                                leading: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 150.0),
                                title: const Text("Frequency",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 18.0),),
                                subtitle: Center(child: Text(snapshot.data!.docs.last['frequence'].toString()+" Hz",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 60.0),)
                                )
                            )),
                        Card(
                            color: SecondaryColor,
                            child: ListTile(
                                leading: const Icon(
                                    Icons.ac_unit,
                                    color: Colors.lightBlueAccent,
                                    size: 150.0),
                                title: const Text("Temperature",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 18.0),),
                                subtitle: Center(child: Text(snapshot.data!.docs.last['temperature'].toString()+" °C",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 60.0),)
                                )
                            )),
                        Card(
                            color: SecondaryColor,
                            child: ListTile(
                                leading: const Icon(
                                    Icons.water,
                                    color: Colors.blue,
                                    size: 150.0),
                                title: const Text("Humidity",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 18.0),),
                                subtitle: Center(child: Text(snapshot.data!.docs.last['humidity'].toString() +" %",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 60.0),)
                                )
                            )),

                      ]
                  );
                }
            )
            )]),
      drawer: const NavDrawer(),
    );
  }

}



