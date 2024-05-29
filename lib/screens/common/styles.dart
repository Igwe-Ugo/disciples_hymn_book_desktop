// ignore_for_file: use_build_context_synchronously
import 'package:disciple_hymn_book_desktop/main.dart';
import 'package:flutter/material.dart';
import 'widget.dart';

abstract class Styles {
  static Color? _selectedColor;
  static Color? get selectedColor => _selectedColor;

  static Future<void> init() async{
    final prefs = BackgroundColorPreferences();
    _selectedColor = await prefs.getBackgroundTheme() ?? Colors.blue;
  }

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: _selectedColor,
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color.fromARGB(255, 89, 90, 91).withOpacity(0.1),
      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }

  static Future<void> chooseColor(BuildContext context) async {
    const List<ColorSwatch> disciplesHymnColor = <ColorSwatch>[
      ColorSwatch(0xFFFFFFFF, {500: Colors.white}),
      ColorSwatch(0xFF000000, {500: Colors.black}),
      Colors.red,
      Colors.redAccent,
      Colors.pink,
      Colors.pinkAccent,
      Colors.purple,
      Colors.purpleAccent,
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.indigo,
      Colors.indigoAccent,
      Colors.blue,
      Colors.blueAccent,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.cyan,
      Colors.cyanAccent,
      Colors.teal,
      Colors.tealAccent,
      Colors.green,
      Colors.greenAccent,
      Colors.lightGreen,
      Colors.lightGreenAccent,
      Colors.lime,
      Colors.limeAccent,
      Colors.yellow,
      Colors.yellowAccent,
      Colors.amber,
      Colors.amberAccent,
      Colors.orange,
      Colors.orangeAccent,
      Colors.deepOrange,
      Colors.deepOrangeAccent,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey
    ];

    List<Widget> listColors(List<ColorSwatch> colors, StateSetter setState) {
      return colors.map((color) {
        bool isSelected = color == _selectedColor;
        return GestureDetector(
            onTap: (){
              setState((){
                _selectedColor = color;
              });
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color, 
              ),
              child: isSelected ? Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ) : null,
            ),
          );
      }).toList();
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Choose Background Color',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              content: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: listColors(disciplesHymnColor, setState),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'cancel'.toUpperCase(),
                    style: const TextStyle(),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final prefs = BackgroundColorPreferences();
                    await prefs.setBackgroundTheme(_selectedColor!);
                    Navigator.pop(context);
                    DiscipleHymnBookDesktop.of(context).changeTheme(_selectedColor!);
                  },
                  child: Text('apply'.toUpperCase()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
