import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:get_storage/get_storage.dart';

class LocalPref {
  final GetStorage storage = GetStorage();

  final loopModeKey = "loopMode";
  final volumeKey = "volume";

  void _set(String key, dynamic value) => storage.write(key, value);

  T? _get<T>(String key) => storage.read(key);

  // void _delete(String key) => storage.remove(key);

  void setLoopMode(LoopMode mode) => _set(
        loopModeKey,
        EnumToString.convertToString(mode),
      );

  LoopMode get loopMode {
    String? loopModeAsString = _get(loopModeKey);

    return EnumToString.fromString(LoopMode.values, loopModeAsString ?? '') ??
        LoopMode.none;
  }

  void setVolume(double volume) => _set(volumeKey, volume);

  double get volume => _get<double>(volumeKey) ?? 0.7;

  ///Singleton factory
  static final LocalPref _instance = LocalPref._internal();

  factory LocalPref() {
    return _instance;
  }

  LocalPref._internal();
}
