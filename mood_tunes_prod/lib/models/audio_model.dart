// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Audio {
  String id;
  String title;
  String audioUrl;
  String artwork;
  String mood;
  Audio({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.artwork,
    required this.mood,
  });

  Audio copyWith({
    String? id,
    String? title,
    String? audioUrl,
    String? artwork,
    String? mood,
  }) {
    return Audio(
      id: id ?? this.id,
      title: title ?? this.title,
      audioUrl: audioUrl ?? this.audioUrl,
      artwork: artwork ?? this.artwork,
      mood: mood ?? this.mood,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'audioUrl': audioUrl,
      'artwork': artwork,
      'mood': mood,
    };
  }

  factory Audio.fromMap(Map<String, dynamic> map) {
    return Audio(
      id: map['id'] as String,
      title: map['title'] as String,
      audioUrl: map['audioUrl'] as String,
      artwork: map['artwork'] as String,
      mood: map['mood'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Audio.fromJson(String source) =>
      Audio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Audio(id: $id, title: $title, audioUrl: $audioUrl, artwork: $artwork, mood: $mood)';
  }

  @override
  bool operator ==(covariant Audio other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.audioUrl == audioUrl &&
      other.artwork == artwork &&
      other.mood == mood;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      audioUrl.hashCode ^
      artwork.hashCode ^
      mood.hashCode;
  }
}
