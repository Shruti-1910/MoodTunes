import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mood_tunes_prod/models/audio_model.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _audioUrlController = TextEditingController();
  String _selectedMood = 'Happy'; // Default mood
  bool uplaoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
      ),
      body: (uplaoding)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextFormField(
                    controller: _audioUrlController,
                    decoration: InputDecoration(labelText: 'Audio URL'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedMood,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMood = newValue!;
                      });
                    },
                    items: <String>[
                      'Happy',
                      'Sad',
                      'Neutral',
                      'Angry',
                      'Surprise',
                      'Fear',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Mood'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        uplaoding = true;
                      });
                      await FirebaseFirestore.instance.collection("songs").add(
                          Audio(
                                  id: "id",
                                  title: _titleController.text,
                                  audioUrl: "audioUrl",
                                  artwork: "artwork",
                                  mood: _selectedMood)
                              .toMap());
                      setState(() {
                        uplaoding = false;
                      });
                      // Add your logic here for form submission
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _audioUrlController.dispose();
    super.dispose();
  }
}
