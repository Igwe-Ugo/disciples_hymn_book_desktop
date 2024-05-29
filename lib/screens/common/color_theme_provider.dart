import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BackgroundColorPreferences {
  static const _kColorKey = 'background_color';

  Future<void> setBackgroundTheme(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_kColorKey, color.value);
  }

  Future<Color?> getBackgroundTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kColorKey)) return null;
    return Color(prefs.getInt(_kColorKey)!);
  }
}
