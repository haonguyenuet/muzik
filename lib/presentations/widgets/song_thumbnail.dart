import 'package:flutter/material.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/presentations/widgets/image_network_widget.dart';

enum ThumbnailSize { sm, md, lg, xl }

class SongThumbnail extends StatelessWidget {
  final SongModel song;
  final ThumbnailSize size;
  final bool playing;

  const SongThumbnail({
    Key? key,
    required this.song,
    this.size = ThumbnailSize.sm,
    this.playing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return playing
        ? PlayingSongThumbnail(
            width: width,
            height: height,
            song: song,
            borderRadius: borderRadius,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: ImageNetworkWidget(
              fit: BoxFit.cover,
              width: width,
              height: height,
              imageUrl: song.illustration,
            ));
  }

  double get width {
    switch (size) {
      case ThumbnailSize.lg:
        return 192;
      case ThumbnailSize.md:
        return 144;
      case ThumbnailSize.xl:
        return 256;
      default:
        return 48;
    }
  }

  double get borderRadius {
    switch (size) {
      case ThumbnailSize.md:
        return 12;
      case ThumbnailSize.lg:
        return 16;
      case ThumbnailSize.xl:
        return 20;
      default:
        return 8;
    }
  }

  double get height => width;
}

class PlayingSongThumbnail extends StatelessWidget {
  final double width;
  final double height;
  final SongModel song;
  final double borderRadius;

  const PlayingSongThumbnail({
    Key? key,
    required this.width,
    required this.height,
    required this.song,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          SongThumbnail(song: song),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                color: Colors.black54,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: Image.asset('assets/images/loading-animation.gif'),
              width: 16,
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
