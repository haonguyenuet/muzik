// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:muzik/controllers/player_controller.dart';
// import 'package:muzik/core/extensions/asset_audio_player_extensions.dart';
// import 'package:muzik/data/models/song_model.dart';
// import 'package:muzik/presentations/widgets/song_thumbnail.dart';

// class SongActionSheet extends StatefulWidget {
//   final SongModel song;

//   const SongActionSheet({Key? key, required this.song}) : super(key: key);

//   @override
//   State<SongActionSheet> createState() => _SongActionSheetState();
// }

// class _SongActionSheetState extends State<SongActionSheet> {
//   late PlayerController playerController;

//   @override
//   void initState() {
//     super.initState();
//     playerController = Get.find();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isCurrent = playerController.player.currentSongId == widget.song.id;

//     return FutureBuilder(
//       future: playerController.queued(widget.song),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox.shrink();
//         }

//         bool queued = snapshot.data!;

//         return ClipRect(
//           child: Container(
//             padding: const EdgeInsets.only(
//               top: 16.0,
//               bottom: 8.0,
//             ),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   const SizedBox
//                       .shrink(), // to properly align the thumbnail area
//                   Column(
//                     children: [
//                       SongThumbnail(
//                         song: widget.song,
//                         size: ThumbnailSize.lg,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         widget.song.title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Text(
//                           widget.song.artist,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(color: Colors.white54),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ListView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     children: <Widget>[
//                       if (!isCurrent)
//                         SongActionButton(
//                           text: 'Play Next',
//                           icon: const Icon(
//                             CupertinoIcons.arrow_right_circle_fill,
//                             color: Colors.white30,
//                           ),
//                           onTap: () {
//                             playerController.queueAfterCurrent(
//                                 song: widget.song);
//                             // showOverlay(
//                             //   context,
//                             //   icon: CupertinoIcons.arrow_right_circle_fill,
//                             //   caption: 'Queued',
//                             //   message: 'Song to be played next.',
//                             // );
//                           },
//                         ),
//                       if (!isCurrent)
//                         SongActionButton(
//                           text: 'Play Last',
//                           icon: const Icon(
//                             CupertinoIcons.arrow_down_right_circle_fill,
//                             color: Colors.white30,
//                           ),
//                           onTap: () {
//                             playerController.queueToBottom(song: widget.song);
//                             // showOverlay(
//                             //   context,
//                             //   icon: CupertinoIcons.arrow_down_right_circle_fill,
//                             //   caption: 'Queued',
//                             //   message: 'Song queued to bottom.',
//                             // );
//                           },
//                         ),
//                       if (queued)
//                         SongActionButton(
//                           text: 'Remove from Queue',
//                           icon: const Icon(
//                             CupertinoIcons.text_badge_minus,
//                             color: Colors.white30,
//                           ),
//                           onTap: () {
//                             playerController.removeFromQueue(song: widget.song);
//                             // showOverlay(
//                             //   context,
//                             //   icon: CupertinoIcons.text_badge_minus,
//                             //   caption: 'Removed',
//                             //   message: 'Song removed from queue.',
//                             // );
//                           },
//                         ),
//                       SongActionButton(
//                         text: 'Mark as Favorite',
//                         icon: const Icon(
//                           CupertinoIcons.heart,
//                           color: Colors.white30,
//                         ),
//                         onTap: () {
//                           // showOverlay(
//                           //   context,
//                           //   caption: widget.song.liked ? 'Unliked' : 'Liked',
//                           //   message: widget.song.liked
//                           //       ? 'Song removed from Favorites.'
//                           //       : 'Song added to Favorites.',
//                           //   icon: widget.song.liked
//                           //       ? CupertinoIcons.heart_slash
//                           //       : CupertinoIcons.heart_fill,
//                           // );
//                           // interactionProvider.toggleLike(song: widget.song);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class SongActionButton extends StatelessWidget {
//   final String text;
//   final Icon icon;
//   final Function onTap;
//   final bool hideSheetOnTap;

//   const SongActionButton({
//     Key? key,
//     required this.text,
//     required this.icon,
//     required this.onTap,
//     this.hideSheetOnTap = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: icon,
//       minLeadingWidth: 16,
//       title: Text(text),
//       onTap: () {
//         onTap();

//         if (hideSheetOnTap) {
//           Navigator.pop(context);
//         }
//       },
//     );
//   }
// }
