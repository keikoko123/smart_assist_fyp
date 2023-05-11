// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/controller/chat_controller.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen.dart';
// import 'package:smart_assist_fyp/models_area3/chat_contact.dart';

// import '../../../common/widgets/loader.dart';

// class ContactsList extends ConsumerWidget {
//   const ContactsList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: StreamBuilder<List<ChatContact>>(
//           stream: ref.watch(chatControllerProvider).chatContacts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Loader();
//             }
//             return ConstrainedBox(
//               constraints: new BoxConstraints(
//                 minHeight: 35.0,
//                 maxHeight: 160.0,
//               ),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data!.length, //?info.length,

//                 itemBuilder: (context, index) {
//                   var chatContactData = snapshot.data![index];
//                   return Column(
//                     children: [
//                      // SizedBox(height: 150, child: Placeholder()),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             MobileChatScreen.routeName,
//                             arguments: {
//                               'name': chatContactData.name,
//                               'uid': chatContactData.contactId,
//                               'isGroupChat': false,
//                               'profilePic': chatContactData.profilePic,
//                             },
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: SizedBox(
//                             height: 200,
//                             child: ListTile(
                              
//                               title: Text(
//                                 chatContactData.name,
//                                 style: const TextStyle(
//                                   fontSize: 40,
//                                 ),
//                               ),
//                               subtitle: Padding(
//                                 padding: const EdgeInsets.only(top: 6.0),
//                                 child: Text(
//                                   chatContactData.lastMessage,
//                                   style: const TextStyle(fontSize: 25),
//                                 ),
//                               ),
                              



//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                   chatContactData.profilePic,
//                                 ),
//                                 radius: 30,
//                               ),
//                               trailing: Text(
//                                 DateFormat.Hm()
//                                     .format(chatContactData.timeSent),
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Divider(color: dividerColor, indent: 85),
//                     ],
//                   );
//                 },
//               ),
//             );
//           }),
//     );
//   }
// }
