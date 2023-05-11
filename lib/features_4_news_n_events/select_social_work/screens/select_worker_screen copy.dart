// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_assist_fyp/features_3_chat_n_gallery/select_contacts/repository/select_contact_repository.dart';
// import 'package:smart_assist_fyp/models_area3/user_model.dart';

// import '../../../common/widgets/error.dart';
// import '../../../common/widgets/loader.dart';

// final getContactsProvider3333 = FutureProvider((ref) {
//   return [
//     UserModel(name: 'Social Work1', uid: "uid", profilePic: "profilePic", isOnline: true, phoneNumber: "33333333", groupId: []),
//     UserModel(name: 'Social Work1', uid: "uid", profilePic: "profilePic", isOnline: true, phoneNumber: "33333333", groupId: []),
//     UserModel(name: 'Social Work1', uid: "uid", profilePic: "profilePic", isOnline: true, phoneNumber: "33333333", groupId: []),

//   ];
// });

// final getContactsProvider4444 = FutureProvider((ref) {
//      var myFuture =  FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'worker').snapshots();
//      return myFuture;

// });


// class SelectWorker_Screen extends ConsumerWidget {
//   static const String routeName = '/select-worker';
//   const SelectWorker_Screen({Key? key}) : super(key: key);

//   // void selectContact( WidgetRef ref, Contact selectedContact, BuildContext context) {
//   //   ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
//   // }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select contact'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.search,
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.more_vert,
//             ),
//           ),
//         ],
//       ),
//       body: ref.watch(getContactsProvider3333).when(
//             data: (workerList) => ListView.builder(
//                 itemCount: workerList.length,
//                 itemBuilder: (context, index) {
//                   final contact = workerList[index];
//                   return InkWell(
//                     onTap:(){},
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 25.0),
//                       child: ListTile(
//                         title: Text(
//                           contact.name,
//                           style: const TextStyle(
//                             fontSize: 45,
//                           ),
//                         ),
//                         leading: contact.profilePic == null
//                             ? null
//                             : CircleAvatar(
//                                 backgroundImage: NetworkImage(contact.profilePic),
//                                 radius: 30,
//                               ),
//                       ),
//                     ),
//                   );
//                 }),
//             error: (err, trace) => ErrorScreen(error: err.toString()),
//             loading: () => const Loader(),
//           ),
//     );
//   }
// }


