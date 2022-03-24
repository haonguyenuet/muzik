import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:muzik/core/values/parse_result_util.dart';
import 'package:muzik/data/models/song_model.dart';
import 'package:muzik/data/source/fake_data.dart';

ParseResult parseSongs(List<dynamic> data) {
  ParseResult result = ParseResult();
  for (var map in data) {
    result.add(SongModel.fromMap(map), map['id']);
  }

  return result;
}

class SongController extends GetxController {
  var songList = <SongModel>[].obs;
  var songMap = <int, SongModel>{};

  Future<void> init() async {
    ParseResult result = await compute(parseSongs, songData);
    songList.value = result.collection.cast();
    songMap = result.index.cast();
  }

  SongModel byId(int id) => songMap[id]!;
}
