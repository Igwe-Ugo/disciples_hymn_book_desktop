// ignore_for_file: must_be_immutable
import '../widget.dart';
import 'package:flutter/material.dart';

class DiscipleshipSideBar extends StatefulWidget {
  final double fontSize;
  Function? changeScreenSideBar;
  DiscipleshipSideBar({super.key, required this.fontSize, this.changeScreenSideBar});

  @override
  State<DiscipleshipSideBar> createState() => _DiscipleshipSideBarState();
}

class _DiscipleshipSideBarState extends State<DiscipleshipSideBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.2),
              Colors.white.withOpacity(0.5),
            ],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [Theme.of(context).primaryColor, Colors.black45],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage(
                      "assets/images/piano.jpeg",
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Text(
                      "disciples' Hymn book".toUpperCase(),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.info_outline,
                  size: widget.fontSize, color: Theme.of(context).primaryColor),
              title: Text(
                'preface'.toUpperCase(),
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Theme.of(context).primaryColor
                ),
              ),
              onTap: () {
                changePageController.jumpToPage(0);
              },
            ),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.settings_outlined, size: widget.fontSize, color: Theme.of(context).primaryColor),
              title: Text(
                'settings'.toUpperCase(),
                style: TextStyle(
                    fontSize: widget.fontSize, color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                changePageController.jumpToPage(1);
              },
            ),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.perm_identity_outlined,
                  size: widget.fontSize, color: Theme.of(context).primaryColor),
              title: Text(
                'about'.toUpperCase(),
                style: TextStyle(
                    fontSize: widget.fontSize, color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                changePageController.jumpToPage(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
