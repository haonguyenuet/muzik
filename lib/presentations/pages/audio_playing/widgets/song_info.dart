import 'package:flutter/material.dart';
import 'package:muzik/data/models/song_model.dart';

class SongInfo extends StatelessWidget {
  final SongModel song;

  const SongInfo({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          song.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          song.artist,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}