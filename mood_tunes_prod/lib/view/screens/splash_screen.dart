import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_tunes_prod/utils/device_size.dart';
import 'package:mood_tunes_prod/view/screens/add_music.dart';
import 'package:mood_tunes_prod/view/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  navigate() async {
    final nav = Navigator.of(context);
    await Future.delayed(Duration(seconds: 3));
    nav.pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/splash4.jpeg",
                  ),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Positioned(
                  top: displayHeight(context) * 0.15,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/logo.jpeg",
                    height: 120,
                  )),
              Positioned(
                top: displayHeight(context) * 0.5,
                left: 0,
                right: 0,
                child: Text(
                  "Mood Tunes",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.2,
              ),
            ],
          )),
    );
  }
}
