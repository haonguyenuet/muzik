import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:muzik/controllers/player_controller.dart';

class AudioControls extends GetView<PlayerController> {
  const AudioControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () {
            controller.previous();
          },
          icon: const Icon(CupertinoIcons.backward_fill),
          iconSize: 48,
        ),
        PlayerBuilder.isPlaying(
          player: controller.player,
          builder: (context, isPlaying) {
            return IconButton(
              onPressed: () => controller.playOrPause(),
              icon: Icon(
                isPlaying
                    ? CupertinoIcons.pause_solid
                    : CupertinoIcons.play_fill,
              ),
              iconSize: 64,
            );
          },
        ),
        IconButton(
          onPressed: () {
            controller.next();
          },
          icon: const Icon(CupertinoIcons.forward_fill),
          iconSize: 48,
        ),
      ],
    );
  }
}
