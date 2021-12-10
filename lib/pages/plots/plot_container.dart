import 'package:flutter/material.dart';
import 'package:flutter_project/pages/menu/navdrawer.dart';
import 'package:flutter_project/pages/plots/plot_container_hf.dart';
import 'package:flutter_project/pages/plots/plot_container_hum.dart';
import 'package:flutter_project/pages/plots/plot_container_temp.dart';

class PlotContainer extends StatefulWidget{
  const PlotContainer({Key? key}) : super(key: key);

  @override
  _PlotContainerState createState() => _PlotContainerState();
}

class _PlotContainerState extends State<PlotContainer> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Plots"),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.favorite_border_outlined),
                  Text('HF'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.thermostat_outlined),
                  Text('TEMP'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.opacity_outlined),
                  Text('HUM'),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(),
      body: TabBarView(
        controller: tabController,
        children: const [
          PlotContainerHF(),
          PlotContainerTEMP(),
          PlotContainerHUM(),
        ],
      ),
    );
  }
}