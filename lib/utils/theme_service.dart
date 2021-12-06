
import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  ThemeMode _mode;

  bool get isDarkMode => _mode == ThemeMode.dark;

  ThemeMode get mode => _mode;

  ThemeService({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode(bool isOn) {
    _mode = isOn ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}
