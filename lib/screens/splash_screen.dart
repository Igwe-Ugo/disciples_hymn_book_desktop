import 'dart:async';
import 'widget.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscipleHymnBookDesktopSplashScreen extends StatefulWidget {
  const DiscipleHymnBookDesktopSplashScreen({super.key});

  @override
  State<DiscipleHymnBookDesktopSplashScreen> createState() => _DiscipleHymnBookDesktopSplashScreenState();
}

class _DiscipleHymnBookDesktopSplashScreenState extends State<DiscipleHymnBookDesktopSplashScreen> {
  bool _isInvisible = false;

  _DiscipleHymnBookDesktopSplashScreenState(){
    Timer(const Duration(seconds: 5), (){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DesktopScreen()), (route) => false);
    });
    Timer(const Duration(milliseconds: 5), (){
      setState(() {
        _isInvisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeNotifier = Provider.of<FontSizeNotifier>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5),
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isInvisible? 1.0:0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset('assets/images/piano.jpeg', width: 100, height: 100,)
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Disciples'\nhymn book".toUpperCase(),
                style: TextStyle(
                  fontSize: fontSizeNotifier.fontSize.toDouble(),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}