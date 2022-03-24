import 'dart:async';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/config/app_color.dart';
import 'package:muzik/config/app_routes.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/controllers/song_controller.dart';
import 'package:muzik/core/constants/style_constant.dart';
import 'package:muzik/core/extensions/asset_audio_player_extensions.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/presentations/pages/audio_playing/widgets/audio_controls.dart';
import 'package:muzik/presentations/pages/audio_playing/widgets/progress_bar.dart';
import 'package:muzik/presentations/pages/audio_playing/widgets/song_info.dart';
import 'package:muzik/presentations/pages/audio_playing/widgets/loop_mode_button.dart';
import 'package:muzik/presentations/pages/audio_playing/widgets/volume_slider.dart';
import 'package:muzik/presentations/widgets/song_thumbnail.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
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
        final songId = playerController.player.currentSongId;
        if (songId == null) return const SizedBox.shrink();
        SongModel song = songController.byId(songId);

        return Stack(
          children: <Widget>[
            Container(color: Colors.black),
            _buildFrostGlassBg(song),
            Container(color: Colors.black54),
            PageView(
              children: [
                _buildMainPage(song),
                LyricsPage(song: song),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainPage(SongModel song) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildThumbnail(song),
          _buildInfoPane(song),
          const SizedBox(height: 8),
          ProgressBar(song: song),
          const AudioControls(),
          Column(
            children: <Widget>[
              const VolumeSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.QUEUE);
                    },
                    icon: const Icon(
                      CupertinoIcons.list_number,
                      color: Colors.white,
                    ),
                  ),
                  const LoopModeButton(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _buildFrostGlassBg(SongModel song) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(song.illustration),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPane(SongModel song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: SongInfo(song: song)),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.ellipsis),
        ),
      ],
    );
  }

  Widget _buildThumbnail(SongModel song) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Hero(
        tag: 'hero-now-playing-thumbnail',
        child: SongThumbnail(song: song, size: ThumbnailSize.xl),
      ),
    );
  }
}

class LyricsPage extends StatefulWidget {
  final SongModel song;
  const LyricsPage({Key? key, required this.song}) : super(key: key);

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late PlayerController playerController;
  late ScrollController scrollController;
  late List<GlobalKey> keys;
  late Timer timer;
  var currentIndex = 0;

  TextStyle timeStampStyle = const TextStyle(
    fontSize: 12,
    color: Colors.white54,
  );

  @override
  void initState() {
    super.initState();
    playerController = Get.find();
    keys = List.generate(
      widget.song.lyrics.length,
      (index) => GlobalKey(),
    );
    scrollController = ScrollController();
    timer = Timer.periodic(
      Duration(seconds: (widget.song.duration / 10).round()),
      (Timer timer) {
        if (currentIndex == widget.song.lyrics.length - 1) {
          timer.cancel();
        }
        scrollToIndex(currentIndex);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void scrollToIndex(int index) {
    // list focus current lyric
    if (scrollController.hasClients) {
      scrollController.position.ensureVisible(
        keys[index].currentContext!.findRenderObject()!,
        alignment: 0.5,
        duration: const Duration(microseconds: 500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lyrics = widget.song.lyrics;
    return StreamBuilder<Duration>(
      stream: playerController.player.currentPosition,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final currentTime = snapshot.data!.inSeconds;
        final _currentIndex =
            lyrics.lastIndexWhere((lyrics) => currentTime >= lyrics.duration);

        if (_currentIndex != currentIndex) {
          currentIndex = _currentIndex;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(lyrics.length, (index) {
                return AnimatedContainer(
                  key: keys[index],
                  duration: StyleConstant.kAnimationDuration,
                  curve: StyleConstant.kAnimationCurve,
                  padding: const EdgeInsets.all(5),
                  color: currentIndex == index
                      ? AppColor.highlight.withOpacity(0.3)
                      : Colors.transparent,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Text(
                    lyrics[index].content,
                    style: const TextStyle(
                      color: AppColor.primaryText,
                      fontSize: 18,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
