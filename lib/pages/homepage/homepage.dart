import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/menu/navdrawer.dart';
import 'package:flutter_project/pages/homepage/current_info.dart';
import 'package:flutter_project/pages/plots/plot_container.dart';
import 'package:flutter_project/utils/fetch_data.dart';

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
    FetchData().addData();
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      drawer: const NavDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryIconTheme.color,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outlined),
                label: "CurrentInfo".tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.insights_outlined), label: "Plots".tr())
          ]),
    );
  }
}
