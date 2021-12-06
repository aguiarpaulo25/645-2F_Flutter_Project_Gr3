import 'package:flutter/material.dart';
import 'package:flutter_project/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text("Choose your preferences", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text("Dark mode"),
            value: theme.isDarkMode,
            onChanged: (value) {
              final provider = Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleMode(value);
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
