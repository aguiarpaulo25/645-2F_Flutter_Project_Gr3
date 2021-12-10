import 'package:flutter/material.dart';
import 'package:flutter_project/pages/menu/navdrawer.dart';
import 'package:flutter_project/pages/plots/plot_container_hf.dart';
import 'package:flutter_project/pages/plots/plot_container_hum.dart';
import 'package:flutter_project/pages/plots/plot_container_temp.dart';
import 'package:flutter_project/utils/firebase_service.dart';

class PlotContainer extends StatefulWidget{
  const PlotContainer({Key? key}) : super(key: key);

  @override
  _PlotContainerState createState() => _PlotContainerState();
}

class _PlotContainerState extends State<PlotContainer> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  final FirebaseService _service = FirebaseService();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var hfData = [];
  var tempData = [];
  var humData = [];

  void updateAllData() {
    _service.getFrequency().then((value) => {
      setState(() {
        hfData = value;
      })
    });

    _service.getTemperature().then((value) => {
      setState(() {
        tempData = value;
      })
    });

    _service.getHumidity().then((value) => {
      setState(() {
        humData = value;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    updateAllData();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateAllData();
    super.build(context);
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