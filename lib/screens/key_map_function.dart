import 'widget.dart';
import 'models/models.dart';
import 'package:keymap/keymap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyMapDiscipleshipDesktop extends StatefulWidget {
  final DiscipleshipHymnaryModel? hymnaryModel;
  final Widget child;
  
  const KeyMapDiscipleshipDesktop({super.key, required this.hymnaryModel, required this.child});

  @override
  State<KeyMapDiscipleshipDesktop> createState() => _KeyMapDiscipleshipDesktopState();
}

class _KeyMapDiscipleshipDesktopState extends State<KeyMapDiscipleshipDesktop> {
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {

    void enterFullScreen(){
      if (!isFullScreen){
        setState(() {
          isFullScreen = true;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandedScreen(hymnaryModelExpanded: widget.hymnaryModel!))).then((_){
          setState(() {
            isFullScreen = false;
          });
        });
      }
    }

    void exitFullScreen(){
      if (isFullScreen) {
        Navigator.of(context).pop();
      }
    }
    return KeyboardWidget(
      bindings: [
        KeyAction(
          LogicalKeyboardKey.keyF,
          'Enter full screen', () {enterFullScreen();},
          isControlPressed: true
        ),
        KeyAction(
          LogicalKeyboardKey.keyE,
          'Exit full screen', () {exitFullScreen();},
          isControlPressed: true
        )
      ],
      child: widget.child,
    );
  }
}