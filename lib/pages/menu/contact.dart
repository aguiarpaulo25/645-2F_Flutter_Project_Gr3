import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Contact"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              tr("ContactText"),
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "contact@connectedtshirt.ch",
              style: TextStyle(fontSize: 22, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
