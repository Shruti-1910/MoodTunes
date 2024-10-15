import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_tunes_prod/models/audio_model.dart';
import 'package:mood_tunes_prod/utils/api_responses.dart';
import 'package:mood_tunes_prod/utils/device_size.dart';
import 'package:mood_tunes_prod/view/screens/music_screen.dart';
import 'package:tflite_v2/tflite_v2.dart';

class MoodRecognitionScreen extends StatefulWidget {
  final File imageFile;
  const MoodRecognitionScreen({super.key, required this.imageFile});

  @override
  State<MoodRecognitionScreen> createState() => _MoodRecognitionScreenState();
}

class _MoodRecognitionScreenState extends State<MoodRecognitionScreen> {
  bool isLoading = true;
  var _recognitions, v;
  String bestMood = "Neutral";

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {
        detectMood(widget.imageFile);
      });
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/mood_detect.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future detectMood(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, numResults: 6, threshold: 0.01, imageMean: 127.5);
    if (recognitions != null) {
      debugPrint(recognitions.toString());
      bestMood = recognitions[0]["label"].toString().split(" ").last;
    }
    debugPrint("Final emotion = $bestMood");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xfbf8f8ff),
        body: Column(
          children: [
            Image.file(
              widget.imageFile,
              height: displayHeight(context) * 0.55,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Mood captured successfully !",
              style: GoogleFonts.mukta(fontSize: 24),
            ),
            Text(
              bestMood,
              style: GoogleFonts.rubik(fontSize: 30),
            ),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            const Text(
              "Proceed with this mood ?",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    child: Container(
                      height: displayHeight(context) * 0.06,
                      width: displayWidth(context) * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          "Retry",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final nav = Navigator.of(context);
                    List<Audio> clips = await getSongsBasedOnMood(bestMood);
                    nav.push(MaterialPageRoute(
                        builder: (context) => MusicScreen(
                              mood: bestMood,
                              audioClips: clips,
                            )));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    child: Container(
                      height: displayHeight(context) * 0.06,
                      width: displayWidth(context) * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xfbEECDA3), Color(0xfbEF629F)])),
                      child: const Center(
                        child: Text(
                          "Proceed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
