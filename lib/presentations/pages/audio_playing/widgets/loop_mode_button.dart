import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/data/source/preferences.dart';

class LoopModeButton extends StatefulWidget {
  const LoopModeButton({Key? key}) : super(key: key);

  @override
  _LoopModeButtonState createState() => _LoopModeButtonState();
}

class _LoopModeButtonState extends State<LoopModeButton> {
  late PlayerController playerController;
  LoopMode loopMode = LoopMode.none;

  @override
  void initState() {
    super.initState();
    playerController = Get.find();
    loopMode = LocalPref().loopMode;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: loopMode == LoopMode.none ? Colors.white24 : Colors.white,
      onPressed: () async {
        late LoopMode newMode;

        switch (loopMode) {
          case LoopMode.none:
            newMode = LoopMode.playlist;
            break;
          case LoopMode.playlist:
            newMode = LoopMode.single;
            break;
          default:
            newMode = LoopMode.none;
            break;
        }

        if (newMode == LoopMode.single &&
            playerController.player.playlist?.numberOfItems == 1) {
          /// Assets Audio Player has a weird bug (?) where setting Single loop
          /// mode when there's only one song in the playlist would simply
          /// crash the app.
          /// Since the previous mode is Playlist, we can safely skip setting
          /// Single mode here, as it would have the same effect anyway.
        } else {
          setState(() => loopMode = newMode);
          playerController.setLoopMode(newMode);
          LocalPref().setLoopMode(newMode);
        }
      },
      icon: Icon(
        loopMode == LoopMode.single
            ? CupertinoIcons.repeat_1
            : CupertinoIcons.repeat,
      ),
    );
  }
}
