import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/repositories/common_firebase_storage_repository.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/models_area3/photo_model.dart';
import 'package:smart_assist_fyp/models_area3/status_model.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';
import 'package:uuid/uuid.dart';

final galleryRepositoryProvider = Provider(
  (ref) => GalleryRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class GalleryRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  GalleryRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadPhoto({
    // required String profilePic,
    required File galleryImage,
    required BuildContext context,
  }) async {
    try {
      var photoID = const Uuid().v1();
      String uid = auth.currentUser!.uid;

      String imageurl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            '/gallery/$uid$photoID',
            galleryImage,
          );

      List<String> statusImageUrls = [];

      //! get
      UserModel? currentUserData;
      var userDataMap = await firestore.collection('users').doc(uid).get();
      currentUserData = UserModel.fromMap(userDataMap.data()!);

      final groupId = currentUserData.groupId[0];

      // //! set
      var statusesSnapshot = await firestore
          .collection('gallery')
          .where(
            'groupId',
            isEqualTo: groupId,
          )
          .get();

      if (statusesSnapshot.docs.isNotEmpty) {
        Gallery gallery = Gallery.fromMap(statusesSnapshot.docs[0].data());
        statusImageUrls = gallery.photoUrl;
        statusImageUrls.add(imageurl);
        await firestore
            .collection('gallery')
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'photoUrl': statusImageUrls,
        });
        return;
      } else {
        statusImageUrls = [imageurl];
      }
      Gallery gallery = Gallery(
        groupId: groupId,
        photoUrl: statusImageUrls,
        createdAt: DateTime.now(),
        photoID: photoID,
      );

      await firestore.collection('gallery').doc(groupId).set(gallery.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<List<String>> getGallery(BuildContext context) async {
    String uid = auth.currentUser!.uid;
    List<String> photoList = [];
    //! get
    UserModel? currentUserData;
    var userDataMap = await firestore.collection('users').doc(uid).get();
    currentUserData = UserModel.fromMap(userDataMap.data()!);

    final groupId = currentUserData.groupId[0];

    Gallery? currentGallery;
    var galleryMap = await firestore.collection('gallery').doc(groupId).get();


    if (galleryMap.data() != null) {
    
    currentGallery = Gallery.fromMap(galleryMap.data()!);

      photoList = currentGallery.photoUrl;
    }

    return photoList;

    // for (int i = 0; i < photoList.length; i++) {
    //   photoList.add(
    //   ));
    // }
    // return [];
  }
}
