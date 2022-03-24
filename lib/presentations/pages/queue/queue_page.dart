import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/presentations/pages/queue/widgets/cover_image_stack.dart';
import 'package:muzik/presentations/pages/queue/widgets/queue_header.dart';
import 'package:muzik/presentations/widgets/song_list.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  late PlayerController playerController;

  @override
  void initState() {
    super.initState();
    playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final queuedSongs = playerController.queuedSongs;

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            Header(
              headingText: 'Current Queue',
              coverImage: CoverImageStack(songs: queuedSongs),
            ),
            if (queuedSongs.isEmpty)
              SliverToBoxAdapter(
                child: Column(
                  children: const [
                    SizedBox(height: 128),
                    Center(
                      child: Text(
                        'No songs queued.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              )
            else
              SliverReorderableList(
                itemCount: queuedSongs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) =>
                        playerController.removeFromQueue(
                      song: queuedSongs[index],
                    ),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(CupertinoIcons.delete_simple),
                      ),
                    ),
                    key: ValueKey(queuedSongs[index]),
                    child: SongCard(song: queuedSongs[index]),
                  );
                },
                onReorder: (int oldIndex, int newIndex) =>
                    playerController.reorderQueue(oldIndex, newIndex),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 160)),
          ],
        ),
      );
    });
  }
}
