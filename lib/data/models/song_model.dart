import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path/path.dart' as path;

class SongModel {
  final int id;
  final String title;
  final String artist;
  final String audio;
  final List<LyricModel> lyrics;
  final String illustration;
  final int duration;

  bool playCountRegistered = false;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.audio,
    required this.lyrics,
    required this.illustration,
    required this.duration,
  });

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      audio: map['audio'] ?? '',
      lyrics: map['lyrics'] != null
          ? List<LyricModel>.from(
              map["lyrics"].map((x) => LyricModel.fromMap(x))).toList()
          : [],
      illustration: map['illustration'] ?? '',
      duration: map['duration']?.toInt() ?? '',
    );
  }

  Future<Audio> asAudio() async {
    Metas metas = Metas(
      title: title,
      artist: artist,
      image: MetasImage.network(illustration),
      extra: {'songId': id},
    );

    return Audio.network(audio, metas: metas);
  }

  @override
  String toString() {
    return 'Data(id: $id, title: $title, artist: $artist, audio: $audio, lyrics: $lyrics, illustration: $illustration)';
  }
}

class LyricModel {
  int duration;
  String content;

  LyricModel(
    this.duration,
    this.content,
  );

  factory LyricModel.fromMap(Map<String, dynamic> map) {
    return LyricModel(
      map['duration']?.toInt() ?? 0,
      map['content'] ?? '',
    );
  }

  @override
  String toString() => 'LyricModel(duration: $duration, content: $content)';
}
