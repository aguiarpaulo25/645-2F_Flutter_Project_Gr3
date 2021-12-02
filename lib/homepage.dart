import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_project/navdrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connected t-shirt"),
      ),
      body: Center(
        child: Column(children: const [
          Text("Welcome, User !",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ]),
      ),
      drawer: const NavDrawer(),
    );
  }
}
