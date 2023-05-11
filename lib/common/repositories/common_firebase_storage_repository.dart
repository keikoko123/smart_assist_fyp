import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//! STEP 2
final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);


//! Repository 嘅特性係會連住其他provider 去使用
class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

}
