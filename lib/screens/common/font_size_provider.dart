import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeNotifier with ChangeNotifier {
  static const String _fontSizeKey = 'fontSizeKey';
  int _fontSize = 15;

  FontSizeNotifier() {
    _loadFontSize();
  }

  int get fontSize => _fontSize;

  void setFontSize(int fontSize) {
    _fontSize = fontSize;
    _saveFontSize(fontSize);
    notifyListeners();
  }

  void _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getInt(_fontSizeKey) ?? 15;
    notifyListeners();
  }

  void _saveFontSize(int fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_fontSizeKey, fontSize);
  }
}
