import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/presentations/pages/audio_playing/audio_playing_page.dart';
import 'package:muzik/presentations/pages/home/home_page.dart';
import 'package:muzik/presentations/pages/queue/queue_page.dart';

abstract class AppRoutes {
  static const String HOME = "/home";
  static const String QUEUE = "/queue";
}

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.QUEUE,
      page: () => const QueuePage(),
      transition: Transition.leftToRight,
    ),
  ];

  Future<void> openAudioPlayingScreen(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const NowPlayingPage(),
        );
      },
    );
  }
}
