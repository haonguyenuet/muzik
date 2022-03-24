import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/controllers/song_controller.dart';
import 'package:muzik/core/constants/dimension_constant.dart';
import 'package:muzik/presentations/widgets/footer_player_sheet.dart';
import 'package:muzik/presentations/widgets/song_list.dart';

import '../../widgets/typography.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SongController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find()..init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            backgroundColor: Colors.black,
            largeTitle: LargeTitle(text: 'Favorite Songs'),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              if (homeController.songList.isEmpty) {
                return Container(
                  color: Colors.white,
                );
              }
              return Column(
                children: homeController.songList
                    .map((song) => SongCard(song: song))
                    .toList(),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: FooterPlayerSheet(),
      ),
    );
  }
}
