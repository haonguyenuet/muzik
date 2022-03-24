import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:muzik/config/app_routes.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/controllers/song_controller.dart';
import 'package:muzik/core/extensions/asset_audio_player_extensions.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/presentations/widgets/song_thumbnail.dart';

class FooterPlayerSheet extends StatefulWidget {
  static Key pauseButtonKey = UniqueKey();
  static Key nextButtonKey = UniqueKey();

  const FooterPlayerSheet({
    Key? key,
  }) : super(key: key);

  @override
  _FooterPlayerSheetState createState() => _FooterPlayerSheetState();
}

class _FooterPlayerSheetState extends State<FooterPlayerSheet> {
  late PlayerController playerController;
  late SongController songController;

  @override
  void initState() {
    super.initState();
    playerController = Get.find();
    songController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Playing?>(
      stream: playerController.player.current,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        int? songId = playerController.player.currentSongId;
        if (songId == null) return const SizedBox.shrink();

        SongModel current = songController.byId(songId);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRect(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 0.5),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: InkWell(
                    onTap: () => AppPages().openAudioPlayingScreen(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Hero(
                          tag: 'hero-now-playing-thumbnail',
                          child: SongThumbnail(song: current),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  current.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  current.artist,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.color,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        playerController.player.builderIsPlaying(
                          builder: (context, isPlaying) {
                            return Row(
                              children: <Widget>[
                                IconButton(
                                  key: FooterPlayerSheet.pauseButtonKey,
                                  onPressed: playerController.playOrPause,
                                  icon: Icon(
                                    isPlaying
                                        ? CupertinoIcons.pause_fill
                                        : CupertinoIcons.play_fill,
                                    size: 24,
                                  ),
                                ),
                                IconButton(
                                  key: FooterPlayerSheet.nextButtonKey,
                                  onPressed: playerController.next,
                                  icon: const Icon(
                                    CupertinoIcons.forward_fill,
                                    size: 24,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
