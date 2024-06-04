import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  final double fontSize;
  const About({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
  String contactEmail = 'discipleshymn@gmail.com';
  Uri urlForEmail = Uri.parse('mailto:$contactEmail');
  String aboutUs = "A careful look at the music played in the Church now shows that the Church is in the wilderness. We are therefore committed to making sure that we bring back the glory of the church through hymns. We are asking that God may visit His saving grace upon our lives and grant us a revival that our land may enter into rest.\n\nIf you have any suggestions or wants to contact us, click the link below.\n\nGrace be with you.";
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/images/piano.jpeg"),
                ),
                const SizedBox(height: 10),
                Text(
                  'Version: 1.0.0',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  aboutUs,
                  style: TextStyle(
                    fontSize: fontSize,
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
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: Text(
                    contactEmail,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}