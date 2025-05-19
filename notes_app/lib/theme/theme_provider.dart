import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  // init in light mode
  ThemeData _themeData = darkMode;

  // getter to access current theme from other parts of the code
  ThemeData get themeData => _themeData;


  // getter method to see if we are in dark mode or not
  bool get isDark => _themeData.brightness == Brightness.dark;

  // setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle to change theme
  void toggleTheme() {
    _themeData = isDark ? lightMode : darkMode;
    notifyListeners();
  }
}