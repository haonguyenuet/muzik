import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:muzik/presentations/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  await GetStorage.init();

  runApp(const MyApp());
}

// const data =
//     "0:00\n♪ I remember the day ♪\n0:13\n♪ Even wrote down the date, that I fell for you (Mm-hmm) ♪\n0:20\n♪ And now it's crossed out in red ♪\n0:22\n♪ But I still can't forget if I wanted too ♪\n0:28\n♪ And it drives me insane ♪\n0:30\n♪ Think I'm hearing your name, everywhere I go ♪\n0:36\n♪ But it's all in my head ♪\n0:40\n♪ It's just all in my head ♪\n0:45\n♪ But you won't see me break, call you up in three days ♪\n0:49\n♪ Or send you a bouquet, saying, “It's a mistake” ♪\n0:53\n♪ Drink my troubles away, one more glass of champagne ♪\n0:57\n♪ And you know ♪\n1:00\n♪ I'm the first to say that I'm not perfect ♪\n1:04\n♪ And you're the first to say you want the best thing ♪\n1:08\n♪ But now I know a perfect way to let you go ♪\n1:12\n♪ Give my last hello, hope it's worth it ♪\n1:17\n♪ Here's your perfect ♪\n1:18\n♪ My best was just fine ♪\n1:20\n♪ I tried, I tried to be great for you ♪\n1:27\n♪ I'm flawed by design and you loved to remind me ♪\n1:31\n♪ No matter what I do ♪\n1:35\n♪ But you won't see me break, call you up in three days ♪\n1:39\n♪ Or send you a bouquet, saying, “It's a mistake” ♪\n1:43\n♪ Drink my troubles away, one more glass of champagne ♪\n1:47\n♪ And you know ♪\n1:50\n♪ I'm the first to say that I'm not perfect ♪\n1:54\n♪ And you're the first to say you want the best thing ♪\n1:58\n♪ But now I know a perfect way to let you go ♪\n2:03\n♪ Give my last hello, hope it's worth it ♪\n2:07\n♪ I'm the first to say that I'm not perfect ♪\n2:11\n♪ And you're the first to say you want the best thing (Best thing, yeah) ♪\n2:15\n♪ But now I know a perfect way to let you go ♪\n2:19\n♪ Give my last hello, hope it's worth it ♪\n2:24\n♪ Say yeah, yeah, yeah ♪\n2:29\n♪ Ayy-ayy, ayy-ayy ♪\n2:32\n♪ But now I know a perfect way to let you go ♪\n2:36\n♪ Give my last hello, hope it's worth it ♪\n2:40\n♪ Here's your perfect ♪";

// class Lyric {
//   int duration;
//   String content;

//   Lyric(
//     this.duration,
//     this.content,
//   );

//   Map<String, dynamic> toMap() {
//     return {
//       'duration': duration,
//       'content': content,
//     };
//   }

//   String toJson() => json.encode(toMap());
// }

// void main() async {
//   final lyrics = data.split("\n");
//   var rawDurations = <String>[];
//   var contents = [];
//   lyrics.asMap().forEach((key, value) {
//     if (key % 2 == 0) {
//       rawDurations.add(value);
//     } else {
//       contents.add(value);
//     }
//   });

//   var durations = rawDurations.map((e) {
//     final pieces = e.split(":");
//     final minute = pieces[0];
//     final second = pieces[1];
//     return int.parse(minute) * 60 + int.parse(second);
//   }).toList();

//   List<String> result = [];

//   durations.asMap().forEach((key, value) {
//     result.add(
//       Lyric(
//         durations[key],
//         contents[key],
//       ).toJson(),
//     );
//   });

//   const filename = '/Users/haonguyen/Dev/mobile/flutter_app/muzik/lib/file.txt';
//   await File(filename).writeAsString(result.toString());
// }
