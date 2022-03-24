import 'package:flutter/material.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/presentations/pages/queue/widgets/cover_image.dart';

class CoverImageStack extends StatelessWidget {
  final List<SongModel> songs;

  const CoverImageStack({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageCount = 4;
    List<String?> images = [];

    if (songs.isNotEmpty) {
      images = songs.map((song) => song.illustration).toList();
      images = images.take(imageCount).toList();
    }

    // fill up to 4 images
    for (int i = images.length; i < imageCount; ++i) {
      images.add(
          "http://sonphuoc.com/wp-content/themes/fox/images/placeholder.jpg");
    }

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          left: -16,
          top: -24,
          child: CoverImage(imageUrl: images[3], overlayOpacity: .8),
        ),
        Positioned(
          left: 32,
          top: -16,
          child: CoverImage(imageUrl: images[2], overlayOpacity: .6),
        ),
        Positioned(
          left: 14,
          top: 20,
          child: CoverImage(imageUrl: images[1], overlayOpacity: .4),
        ),
        CoverImage(imageUrl: images[0]),
      ],
    );
  }
}
