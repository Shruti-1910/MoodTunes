import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_tunes_prod/models/audio_model.dart';

Future<List<Audio>> getSongsBasedOnMood(String mood) async {
  List<Audio> songs = [];
  var response = await FirebaseFirestore.instance
      .collection("songs")
      .where("mood", isEqualTo: mood)
      .get();
  
  for (var i = 0; i < response.docs.length; i++) {
    Audio audio = Audio.fromMap(response.docs[i].data());
    songs.add(audio);
  }
  return songs;
}
