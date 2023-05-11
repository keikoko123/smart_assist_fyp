import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_assist_fyp/common/enums/message_enum.dart';
import 'package:smart_assist_fyp/common/providers/message_reply_provider.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/controller/chat_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/repositories/chat_repository.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/message_reply_preview.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:image_picker/image_picker.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;

  final TextEditingController _messageController = TextEditingController();

  FlutterSoundRecorder? _soundRecorder;

  bool isRecorderInit = false;

  bool isShowEmojiContainer = false;

  bool isRecording = false;

  FocusNode focusNode = FocusNode();

  //! method 1
  void sendTextMessage() async {


    final messageResult = _messageController.text.trim();

    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            messageResult,
            widget.recieverUserId,
            widget.isGroupChat,
          );
      debugPrint(messageResult + "----step1 is ok");
      setState(() {
        _messageController.text = '';
        isShowSendButton = false;
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      ref.read(chatControllerProvider).sendGIFMessage(
            context,
            gif.url,
            widget.recieverUserId,
            widget.isGroupChat,
          );
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void initState() {
    super.initState();
    _messageController.text = '';
    _soundRecorder = FlutterSoundRecorder();

    ref.read(chatRepositoryProvider);

    ref.read(authControllerProvider);

    ref.read(userDataAuthProvider);
    
    ref.read(chatControllerProvider);

    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                keyboardType: TextInputType.name,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: mobileChatBoxColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Colors.orange), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(40.0),
                  ),

                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20.0),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: toggleEmojiKeyboardContainer,
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: selectGIF,
                            icon: const Icon(
                              Icons.gif,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectImage, //selectImage
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: selectVideo,
                          icon: const Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(
                      width: 2, color: Colors.orange,
                      //style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 35,
                child: GestureDetector(
                  child: Icon(
                    isShowSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                  //! method 1
                  onTap: sendTextMessage,
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
