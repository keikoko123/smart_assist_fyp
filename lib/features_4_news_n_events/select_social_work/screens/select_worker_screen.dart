import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen%20copy.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/select_contacts/repository/select_contact_repository.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';

import '../../../common/widgets/error.dart';
import '../../../common/widgets/loader.dart';

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

class SelectWorker_Screen extends ConsumerWidget {
  static const String routeName = '/select-worker';
  const SelectWorker_Screen({Key? key}) : super(key: key);

  // void selectContact( WidgetRef ref, BuildContext context) {
  //   ref.read(selectContactControllerProvider).selectContact( context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider2).when(
            data: (workerList) => ListView.builder(
                itemCount: workerList.length,
                itemBuilder: (context, index) {
                  final contact = workerList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MobileChatScreen.routeName,
                        arguments: {
                          'name': contact.name,
                          'uid': contact.uid,
                          'isGroupChat': false,
                          'profilePic': contact.profilePic,
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: ListTile(
                        title: Text(
                          contact.name,
                          style: const TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        subtitle: (contact.isOnline)? Text("Online", style: TextStyle(color: Colors.green[700], fontSize: 18, fontWeight: FontWeight.w700),): Text("Offline", style: TextStyle(color: Colors.red[700], fontSize: 18, fontWeight: FontWeight.w700),),
                        leading: contact.profilePic == null
                            ? null
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(contact.profilePic),
                                radius: 30,
                              ),
                      ),
                    ),
                  );
                }),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
