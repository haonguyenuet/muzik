import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/core/extensions/extension_barrel.dart';
import 'package:muzik/core/mixins/stream_subscriber.dart';
import 'package:muzik/data/models/song_model.dart';

class ProgressBar extends StatefulWidget {
  final SongModel song;

  const ProgressBar({Key? key, required this.song}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with StreamSubscriber {
  late PlayerController playerController;
  late Duration _duration, _position;
  bool _shouldAutoUpdatePosition = true;

  TextStyle timeStampStyle = const TextStyle(
    fontSize: 12,
    color: Colors.white54,
  );

  @override
  void initState() {
    super.initState();
    playerController = Get.find();

    _duration = Duration(seconds: widget.song.duration.toInt());
    _position = const Duration(seconds: 0);

    subscribe(playerController.player.currentPosition.listen((position) {
      if (_shouldAutoUpdatePosition) {
        setState(() => _position = position);
      }
    }));
  }

  /// Since this widget is rendered inside NowPlayingScreen, change to current
  /// song in the parent will not trigger initState() and as a result not
  /// refresh the progress bar's values.
  /// For that, we hook into didUpdateWidget().
  /// See https://stackoverflow.com/questions/54759920/flutter-why-is-child-widgets-initstate-is-not-called-on-every-rebuild-of-pa.
  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() => _duration = Duration(seconds: widget.song.duration.toInt()));
  }

  @override
  void dispose() {
    unsubscribeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Slider(
          value: _position.inSeconds.toDouble(),
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() => _position = Duration(seconds: value.toInt()));
          },
          onChangeStart: (_) => _shouldAutoUpdatePosition = false,
          onChangeEnd: (double value) {
            _shouldAutoUpdatePosition = true;
            playerController.player.seek(Duration(seconds: value.toInt()));
          },
        ),
        Container(
          // move the timestamps up a bit
          transform: Matrix4.translationValues(0.0, -4.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_position.toMs(), style: timeStampStyle),
              Text((_duration - _position).toMs(), style: timeStampStyle),
            ],
          ),
        ),
      ],
    );
  }
}
