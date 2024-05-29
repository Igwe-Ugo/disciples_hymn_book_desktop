// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HymnTune extends StatefulWidget {
  final String hymnMusicPath;
  const HymnTune({super.key, required this.hymnMusicPath});

  @override
  _HymnTuneState createState() => _HymnTuneState();
}

class _HymnTuneState extends State<HymnTune> with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isPlaying = false;
  double iconSize = 30.0;
  final AudioPlayer hymnTunePlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    loadMusic();
  }

  Future<void> loadMusic() async {
    if (widget.hymnMusicPath.isNotEmpty) {
      try {
        await hymnTunePlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.hymnMusicPath)));
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error Loading audio source: $e',
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM
        );
      }
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: 'No Internet Connection',
      textColor: Colors.white,
      backgroundColor: Colors.black45,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => animateIcon(),
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: iconController,
        size: iconSize,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void animateIcon() async {
    if (widget.hymnMusicPath.isNotEmpty) {
      bool isConnected = await checkInternetConnection();

      if (!isConnected) {
        showNoInternetToast();
        return;
      }

      setState(() {
        isPlaying = !isPlaying;
      });

      if (isPlaying) {
        await iconController.forward();
        await hymnTunePlayer.play();
      } else {
        await iconController.reverse();
        await hymnTunePlayer.pause();
      }
    }
  }

  @override
  void dispose() {
    hymnTunePlayer.dispose();
    iconController.dispose();
    super.dispose();
  }
}
