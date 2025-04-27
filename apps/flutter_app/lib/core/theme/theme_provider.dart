import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );

ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
