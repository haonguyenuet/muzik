import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:mutex/mutex.dart';
import 'package:muzik/controllers/song_controller.dart';
import 'package:muzik/core/extensions/asset_audio_player_extensions.dart';
import 'package:muzik/core/mixins/stream_subscriber.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/data/source/preferences.dart';

class PlayerController extends GetxController with StreamSubscriber {
  final SongController songController = Get.find();
  final AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  final _mutex = Mutex();

  var queuedSongs = <SongModel>[].obs;

  Future<void> _openPlayer(audioResource) async {
    assert(audioResource is Audio || audioResource is List<Audio>,
        'audioResource must be of either Audio or List<Audio> type.');

    await player.open(
      Playlist(
        audios: audioResource is Audio ? [audioResource] : audioResource,
      ),
      showNotification: true,
      autoStart: false,
      loopMode: LocalPref().loopMode,
      volume: LocalPref().volume,
    );
  }

  Future<bool> queued(SongModel song) async => await indexInQueue(song) != -1;

  Future<int> indexInQueue(SongModel song) async {
    return player.playlist?.audios.indexOf(await song.asAudio()) ?? -1;
  }

  Future<void> play({SongModel? song}) async {
    await _mutex.acquire();

    try {
      if (song == null) {
        return;
      }
      await player.playlistPlayAtIndex(await queueToTop(song: song));
    } finally {
      _mutex.release();
    }
  }

  Future<bool> previous() => player.previous();

  Future<bool> next() => player.next();

  Future<void> playOrPause() => player.playOrPause();

  Future<void> stop() => player.stop();

  Future<void> setVolume(double volume) => player.setVolume(volume);

  Future<void> setLoopMode(LoopMode mode) => player.setLoopMode(mode);

  /////////////////////////////////////////////////////////
  Future<int> queueToTop({required SongModel song}) async {
    if (player.playlist == null) {
      await _openPlayer(await song.asAudio());
    } else {
      final index = await indexInQueue(song);

      if (index != -1) {
        reorderQueue(index, 0);
      } else {
        player.playlist!.insert(0, await song.asAudio());
      }
    }

    refreshQueuedSongs();
    return 0;
  }

  void reorderQueue(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }

    final audio = player.playlist?.audios[oldIndex];

    if (audio != null) {
      player.playlist
        ?..remove(audio)
        ..insert(newIndex, audio);
    }
  }

  Future<void> removeFromQueue({required SongModel song}) async {
    if (player.currentSongId != null && player.currentSongId == song.id) {
      // playing the song in the back
      int index = await indexInQueue(song);
      if (index != queuedSongs.length - 1) {
        await player.playlistPlayAtIndex(index + 1);
      } else {
        player.stop();
      }
    }

    player.playlist?.audios.remove(await song.asAudio());
    refreshQueuedSongs();
  }

  void clearQueue() {
    player.playlist?.audios.clear();
    refreshQueuedSongs();
  }

  void refreshQueuedSongs() {
    queuedSongs.value = player.playlist?.audios
            .map((audio) => songController.byId(audio.songId!))
            .toList() ??
        [];
  }
}
