import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/core/constants/dimension_constant.dart';
import 'package:muzik/core/extensions/asset_audio_player_extensions.dart';
import 'package:muzik/core/mixins/stream_subscriber.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/presentations/widgets/song_thumbnail.dart';


class SongCard extends GetView<PlayerController> {
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async => await controller.play(song: song),
      key: UniqueKey(),
      contentPadding: DimensionConstants.defaultPadding,
      shape: Border(bottom: Divider.createBorderSide(context)),
      leading: SongCardThumbnail(song: song),
      title: Text(song.title, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        song.artist,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white60),
      ),
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.ellipsis, size: 20),
        onPressed: () {},
      ),
    );
  }
}

class SongCardThumbnail extends StatefulWidget {
  final SongModel song;

  const SongCardThumbnail({Key? key, required this.song}) : super(key: key);

  @override
  _SongCardThumbnailState createState() => _SongCardThumbnailState();
}

class _SongCardThumbnailState extends State<SongCardThumbnail>
    with StreamSubscriber {
  late PlayerController playerController;
  PlayerState playerState = PlayerState.stop;
  bool isCurrentSong = false;

  @override
  void initState() {
    super.initState();

    playerController = Get.find();

    subscribe(playerController.player.playerState.listen((PlayerState state) {
      setState(() => playerState = state);
    }));

    subscribe(playerController.player.current.listen((Playing? current) {
      setState(() => isCurrentSong =
          playerController.player.currentSongId == widget.song.id);
    }));
  }

  @override
  void dispose() {
    unsubscribeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SongThumbnail(
      song: widget.song,
      playing: playerState == PlayerState.play && isCurrentSong,
    );
  }
}
