import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood_tunes_prod/view/screens/add_music.dart';
import 'package:mood_tunes_prod/view/screens/home_screen.dart';
import 'package:mood_tunes_prod/view/screens/splash_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MoodTunes());
}

class MoodTunes extends StatelessWidget {
  const MoodTunes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
