// ignore_for_file: must_be_immutable
import '../widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              leading: Icon(Icons.settings, size: widget.fontSize, color: Theme.of(context).primaryColor),
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
              leading: Icon(Icons.perm_device_information_outlined,
                  size: widget.fontSize, color: Theme.of(context).primaryColor),
              title: Text(
                'about'.toUpperCase(),
                style: TextStyle(
                    fontSize: widget.fontSize, color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                aboutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future aboutDialog(BuildContext context) {
    const String contactEmail = 'discipleshymn@gmail.com';
    final Uri urlForEmail = Uri.parse('mailto:$contactEmail');
    const String aboutUs = "A careful look at the music played in the Church now shows that the Church is in the wilderness. We are therefore committed to making sure that we bring back the glory of the church through hymns. We are asking that God may visit His saving grace upon our lives and grant us a revival that our land may enter into rest.\n\nIf you have any suggestions or wants to contact us, click the link below.\n\nGrace be with you.";
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'about'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/images/piano.jpeg"),
              ),
              const SizedBox(height: 10),
              const Text(
                "Disciple's Hymn Book",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                aboutUs,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                hoverColor: Colors.grey,
                onTap: () async {
                  if (await canLaunchUrl(urlForEmail)) {
                    await launchUrl(urlForEmail);
                  } else {
                    debugPrint('Cant');
                  }
                },
                leading: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 50,
                    minHeight: 50,
                  ),
                  child: const Icon(
                    Icons.email_rounded,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                subtitle: const Text(
                  contactEmail,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white
              ),
              child: Text(
                'close'.toUpperCase(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
