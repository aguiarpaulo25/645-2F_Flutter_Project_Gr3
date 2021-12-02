import 'package:flutter/material.dart';
import 'package:flutter_project/theme_service.dart';
import 'package:provider/src/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text("Choose your preferences", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text("Dark mode"),
            value: isDark,
            onChanged: (bool value) {
              setState(() {
                isDark = value;
              });
              context.read<ThemeService>().toggleMode();
            },
          ),
          const ListTile(
            title: Text("Language"),
          )
        ],
      ),
    );
  }
}
