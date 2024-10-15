import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_tunes_prod/utils/device_size.dart';
import 'package:mood_tunes_prod/view/screens/mood_recog_screen.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  

  

  Future<void> _pickImage(ImageSource imageSource) async {
    try {
      final navigator = Navigator.of(context);
      final XFile? image = await _picker.pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _image = image;
          file = File(image.path);
        });
        // await Future.delayed(Duration(microseconds: 100));
        navigator.push(MaterialPageRoute(
            builder: (context) => MoodRecognitionScreen(
                  imageFile: file!,
                )));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfb7de4ea),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
              Text(
                "How are you feeling today",
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit(
                  fontWeight: FontWeight.w600,
                  fontSize: 46,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        await _pickImage(ImageSource.camera);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.black,
                      height: 45,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Take a photo",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        await _pickImage(ImageSource.gallery);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.black,
                      height: 45,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Pick from gallery",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
