import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/theme_colors.dart';
import 'package:flutter_project/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropDownValue = "English";
  List<String> dropDownList = [
    'English',
    'Français',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Settings").tr(),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text("Choose your preferences",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text("Dark mode"),
            value: theme.isDarkMode,
            onChanged: (value) {
              final provider =
                  Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleMode(value);
            },
          ),
          const ListTile(
            title: Text("Language"),
          ),
          DropdownButton<String>(
            value: dropDownValue,
            elevation: 10,
            underline: Container(
              height: 2,
              color: ThemeColors.lightTheme.primaryColor,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;

                switch (newValue) {
                  case "English":
                    EasyLocalization.of(context)!
                        .setLocale(const Locale('en', 'US'));
                    break;
                  case "Français":
                    EasyLocalization.of(context)!
                        .setLocale(const Locale('fr', 'FR'));
                    break;
                  default:
                    EasyLocalization.of(context)!
                        .setLocale(const Locale('en', 'US'));
                }
              });
            },
            items: dropDownList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
