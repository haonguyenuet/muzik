import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/controllers/player_controller.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({Key? key}) : super(key: key);

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  late PlayerController playerController;
  double volume = .7;

  @override
  void initState() {
    super.initState();
    playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          getVolumnIcon(),
          size: 16,
          color: Colors.white54,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SliderTheme(
              data: Theme.of(context).sliderTheme.copyWith(
                    trackHeight: 2,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
              child: Slider(
                min: 0.0,
                max: 1.0,
                value: volume,
                onChanged: (value) {
                  setState(() => volume = value);
                  playerController.setVolume(value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData getVolumnIcon() {
    if (volume == 0) {
      return CupertinoIcons.volume_off;
    }
    if (volume < 0.3) {
      return CupertinoIcons.volume_mute;
    }
    if (volume > 0.3 && volume < 0.8) {
      return CupertinoIcons.volume_down;
    }
    return CupertinoIcons.volume_up;
  }
}
