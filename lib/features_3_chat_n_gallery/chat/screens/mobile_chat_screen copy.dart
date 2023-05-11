// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/chat_list.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
// import 'package:smart_assist_fyp/models_area3/user_model.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/bottom_chat_field.dart';

// import '../../../common/widgets/loader.dart';
// import '../../../features_0_common/auth/controller/auth_controller.dart';

// //! MobileChatScreen
// class MobileChatScreen extends ConsumerWidget {
//   static const String routeName = '/mobile-chat-screen';
//   final String name;
//   final String uid;
//   final bool isGroupChat;
//   final String profilePic;
//   const MobileChatScreen({
//     Key? key,
//     required this.name,
//     required this.uid,
//     required this.isGroupChat,
//     required this.profilePic,
//   }) : super(key: key);

//   void makeCall(WidgetRef ref, BuildContext context) {
//     // ref.read(callControllerProvider).makeCall(
//     //       context,
//     //       name,
//     //       uid,
//     //       profilePic,
//     //       isGroupChat,
//     //     );
//   }


//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //CallPickupScreen(
//     //scaffold:
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         backgroundColor: Colors.orange,
//           title: isGroupChat
//               ? Text(name)
//               : StreamBuilder<UserModel>(
//             stream: ref.read(authControllerProvider).userDataById(uid),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Loader();
//               }
//               return Column(
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   Text(
//                     snapshot.data!.isOnline ? 'online' : 'offline',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             onPressed: () => makeCall(ref, context),
//             icon: const Icon(Icons.video_call),
//             color: Colors.black,
//             iconSize: 35,
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.call),
//             color: Colors.black,
//             iconSize: 30,

//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.more_vert),
//             color: Colors.black,
//             iconSize: 35,

//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child:
//                 ChatList(recieverUserId: uid, isGroupChat: isGroupChat 
//                     ),
//           ),
//           BottomChatField(
//             recieverUserId: uid,
//             isGroupChat: isGroupChat, //sendTextMessage
//           ),
//         ],
//       ),
//     );
//   }
// }
