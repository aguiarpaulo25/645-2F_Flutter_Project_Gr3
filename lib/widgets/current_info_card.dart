import 'package:flutter/material.dart';

class CurrentInfoCard extends StatefulWidget {
   final String cardTitle;
   final IconData cardIcon;
   final String connectionToDb;
   final Color cardColor;

  const CurrentInfoCard({Key? key, required this.cardTitle, required this.cardIcon, required this.connectionToDb, required this.cardColor}) : super(key: key);

  @override
  _CurrentInfoCardState createState() => _CurrentInfoCardState();
}

class _CurrentInfoCardState extends State<CurrentInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.cardColor,
        child: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 25.0)),
              Text(
                widget.cardTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0,
                    color: Theme.of(context).primaryColorDark),
              )
            ],
          ),
          ListTile(
              leading: Icon(widget.cardIcon,
                  color: Theme.of(context).primaryColorDark,
                  size: 90.0),
              subtitle: Center(
                  child: Column(children: [
                    const Padding(
                        padding:
                        EdgeInsets.only(left: 25.0, top: 30.0)),
                    Text(
                      widget.connectionToDb,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          color: Theme.of(context).primaryColorDark),
                    )
                  ]))),
          //const Padding(padding: EdgeInsets.all(0))
        ]));
  }
}
