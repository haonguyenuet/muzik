import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';

extension AssetsAudioPlayerExtension on AssetsAudioPlayer {
  static String? _songId;

  Future<void> restart() async {
    seek(const Duration(seconds: 0), force: true);
  }

  int? get currentSongId => _songId ?? getCurrentAudioextra['songId'];

  @visibleForTesting
  void setSongId(String id) => _songId = id;
}

extension AudioExtension on Audio {
  int? get songId => metas.extra?['songId'];
}
