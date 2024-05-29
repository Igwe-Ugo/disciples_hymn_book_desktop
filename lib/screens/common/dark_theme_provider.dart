import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscipleshipHymnaryPreferences {
  static const themeStatus = "THEMESTATUS";
  
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DiscipleshipHymnaryPreferences discipleshipHymnaryPreferences = DiscipleshipHymnaryPreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    discipleshipHymnaryPreferences.setDarkTheme(value);
    notifyListeners();
  }
}
