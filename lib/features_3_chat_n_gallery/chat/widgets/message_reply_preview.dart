import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/providers/message_reply_provider.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! use reply provider
    final messageReply = ref.watch(messageReplyProvider);


    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [

          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'Me' : 'Opposite',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap: () {
                  ref
                      .read(messageReplyProvider.notifier)
                      .update((state) => null);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          DisplayTextImageGIF(
            message: messageReply.message,
            type: messageReply.messageEnum,
          ),
        ],
      ),
    );
  }
}
