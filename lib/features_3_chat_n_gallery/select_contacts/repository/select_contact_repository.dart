import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen.dart';

import '../../../common/utils/utils.dart';
import '../../../models_area3/user_model.dart';

//! First Provider is the acutall class to be a globla object(instance)
final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);
//! Provider 2
final getContactsProvider = FutureProvider((ref) {
  return ref.watch(selectContactsRepositoryProvider).getContacts();
});

//! Provider 2
final getContactsProvider2 = FutureProvider((ref) {
  return ref.watch(selectContactsRepositoryProvider).getContacts2();
});

//! pROVDIER 3
final selectContactControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContactController(
    ref: ref,
    selectContactRepository: selectContactRepository,
  );
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepository.selectContact(selectedContact, context);
  }
}

//! ALL PROVIDDERS IN TOP --------------------------------------------------

//* ALL CLASS IN BOTTOM ----------------------------------------------------

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  Future<List<UserModel>> getContacts2() async {
    List<UserModel> workerList = [];

    var userCollection2 = await firestore
        .collection('users')
        .where('role', isEqualTo: 'worker')
        .get();
    debugPrint("$userCollection2");

    for (var document in userCollection2.docs) {
      debugPrint("312");
      var userData = UserModel.fromMap(document.data());

      workerList.add(userData);

      debugPrint(userData.uid + "++++++++++++++");
      debugPrint(userData.name + "++++++++++++++");
    }

    return workerList;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      // var userCollection2 = await firestore
      //     .collection('users')
      //     .where('role', isEqualTo: 'worker')
      //     .get();
      // debugPrint("$userCollection2");

      // for (var document in userCollection2.docs) {
      //   debugPrint("312");
      //   var userData = UserModel.fromMap(document.data());

      //   debugPrint(userData.uid + "++++++++++++++");
      //   debugPrint(userData.name + "++++++++++++++");
      // }

      var userCollection = await firestore.collection('users').get();

      debugPrint("$userCollection");

      //await firestore.collection('users').doc(uid).set(user.toMap());

      bool isFound = false;
      for (var document in userCollection.docs) {
        debugPrint("123");
        var userData = UserModel.fromMap(document.data());

        String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(
          ' ',
          '',
        );
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;

          //!!!!-----------------
          Navigator.pushNamed(
            context,
            MobileChatScreen.routeName,
            arguments: {
              'name': userData.name,
              'uid': userData.uid,
              'isGroupChat': false,
              'profilePic': userData.profilePic,
            },
          );
        }
      }

      if (!isFound) {
        const number = '+852 6886 8112'; //set the number here
        await FlutterPhoneDirectCaller.callNumber(number);

        // showSnackBar(
        //   context: context,
        //   content: 'This number does not exist on this app.',
        // );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
