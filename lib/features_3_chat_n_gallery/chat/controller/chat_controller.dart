import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/enums/message_enum.dart';
import 'package:smart_assist_fyp/common/providers/message_reply_provider.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';
import 'package:smart_assist_fyp/models_area3/chat_contact.dart';
import 'package:smart_assist_fyp/models_area3/message.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';

import '../repositories/chat_repository.dart';
import 'package:smart_assist_fyp/models_area3/group.dart';

//! provider 1 for the instance of chat respostory and provider its methods
final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReply = ref.read(messageReplyProvider);

    ref.read(userDataAuthProvider).whenData((value) {
      debugPrint(text.trim() + "----step2 is start");

      chatRepository.sendTextMessage(
        context: context,
        text: text,
        recieverUserId: recieverUserId,
        senderUser: value!,
        messageReply: messageReply,
        isGroupChat: isGroupChat,
      );
      debugPrint(text.trim() + "----step2 is ok");
    });

    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value!,
            messageEnum: messageEnum,
            ref: ref,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          ),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
            context: context,
            gifUrl: newgifUrl,
            recieverUserId: recieverUserId,
            senderUser: value!,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          ),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  //! home page
  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  //! home page
  Stream<List<ChatContact>> getChatContacts_Workers() {
    return chatRepository.getChatContacts_Workers();
  }

  Stream<List<Group>> chatGroups() {
    return chatRepository.getChatGroups();
  }

  //! chatting page
  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  Stream<List<Message>> groupChatStream(String groupId) {
    return chatRepository.getGroupChatStream(groupId);
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }
}
