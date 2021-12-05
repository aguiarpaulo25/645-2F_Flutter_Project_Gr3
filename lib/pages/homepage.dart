import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_project/navdrawer.dart';
import 'package:flutter_project/pages/current_info.dart';
import 'package:flutter_project/pages/plots/plot_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  final screens = [
    const CurrentInfo(),
    const PlotContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      drawer: const NavDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF03DAC5),
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'Current info'),
            BottomNavigationBarItem(
                icon: Icon(Icons.insights_outlined),
                label: 'Plots')
          ]),
    );
  }
}
