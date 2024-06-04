import 'common/widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Color _hoverColor = Colors.transparent.withOpacity(0.1);
  static List<int> fontSizeItems = [
    10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
  ];

  @override
  Widget build(BuildContext context) {
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Card(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          children: [
            ListTile(
              hoverColor: _hoverColor,
              leading: Icon(
                Icons.font_download_outlined,
                size: fontSizeNotifier.fontSize.toDouble(),
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Select Font Size',
                style: TextStyle(
                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '${fontSizeNotifier.fontSize} dp',
                style: TextStyle(
                  fontSize: fontSizeNotifier.fontSize.toDouble()
                ),
              ),
              onTap: () => _showFontSizePickerDialog(context),
            ),
            const SizedBox(height: 10,),
            ListTile(
              hoverColor: _hoverColor,
              leading: Icon(
                Icons.color_lens_outlined,
                size: fontSizeNotifier.fontSize.toDouble(),
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Select Background Color',
                style: TextStyle(
                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () => Styles.chooseColor(context),
            ),
            const SizedBox(height: 10,),
            ListTile(
              leading: Icon(
                Icons.wb_sunny_outlined,
                size: fontSizeNotifier.fontSize.toDouble(),
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Select Dark Theme',
                style: TextStyle(
                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Switch(
                activeColor: Theme.of(context).primaryColor,
                value: themeChange.darkTheme,
                onChanged: (value) {
                  setState(() {
                    themeChange.darkTheme = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFontSizePickerDialog(BuildContext context) async {
    int tempFontSize = Provider.of<FontSizeNotifier>(context, listen: false).fontSize;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Hymn verse font size'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fontSizeItems.length,
                  itemBuilder: (context, index) {
                    final intValue = fontSizeItems[index];
                    return ListTile(
                      hoverColor: _hoverColor,
                      leading: Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: intValue,
                        groupValue: tempFontSize,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              tempFontSize = value;
                            });
                            Provider.of<FontSizeNotifier>(context, listen: false).setFontSize(value);
                          }
                        },
                      ),
                      title: Text('$intValue sp'),
                      onTap: () {
                        setState(() {
                          tempFontSize = intValue;
                        });
                        Provider.of<FontSizeNotifier>(context, listen: false).setFontSize(intValue);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('cancel'.toUpperCase()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
