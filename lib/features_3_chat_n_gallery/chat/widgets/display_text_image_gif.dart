import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/enums/message_enum.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/video_player_item.dart';

class DisplayTextImageGIF extends ConsumerStatefulWidget {
  // const DisplayTextImageGIF({super.key});
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DisplayTextImageGIFState();
}

class _DisplayTextImageGIFState extends ConsumerState<DisplayTextImageGIF> {
  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return widget.type == MessageEnum.text
        ? Text(
            widget.message,
            style: const TextStyle(
              fontSize: 30,
            ),
          )
        : widget.type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 70,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(widget.message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                    audioPlayer.onPlayerComplete.listen((event) {
                      setState(() {
                        isPlaying = false;
                      });
                    });
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 40,
                  ),
                );
              })
            : widget.type == MessageEnum.video
                ? VideoPlayerItem(
                    videoUrl: widget.message,
                  )
                : widget.type == MessageEnum.gif
                    ? CachedNetworkImage(
                        imageUrl: widget.message,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.message,
                      );
  }
}
