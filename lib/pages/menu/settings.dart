import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/fetch_data.dart';
import 'package:flutter_project/utils/theme_colors.dart';
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

    var actualLocale = EasyLocalization.of(context)!.currentLocale.toString();
    String dropDownValue;
    switch (actualLocale) {
      case "fr_FR":
        dropDownValue = "Français";
        break;
      default:
        dropDownValue = "English";
        break;
    }
    List<String> dropDownList = [
      'English',
      'Français',
    ];

    List<int> refreshValueList = [1, 6, 11, 16, 20, 25, 30];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Settings").tr(),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text("SettingsText",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                .tr(),
          ),
          SwitchListTile(
            title: const Text("DarkMode").tr(),
            value: theme.isDarkMode,
            onChanged: (value) {
              final provider =
                  Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleMode(value);
            },
          ),
          ListTile(title: const Text("RefreshRate").tr()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: refreshValueList.map((e) => Text(e.toString())).toList(),
          ),
          Slider(
              value: FetchData.refreshRate,
              max: 30,
              min: 1,
              divisions: 6,
              label: FetchData.refreshRate.round().toString(),
              onChanged: (double value) {
                setState(() {
                  FetchData().restartTimer(value);
                });
              }),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text("Language").tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: DropdownButton<String>(
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
                  items: dropDownList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
