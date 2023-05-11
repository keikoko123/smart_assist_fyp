// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/app_home.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/signin_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/repositories/common_firebase_storage_repository.dart';
import '../../../models_area3/user_model.dart';
import '../../../features_3_chat_n_gallery/mobile_layout_screen.dart';
import '../controller/auth_controller.dart';
import '../screens/otp_screen.dart';
import '../screens/user_information_screen.dart';
//import '../../../features_3_chat_n_gallery/mobile_layout_screen.dart';
import 'package:restart_app/restart_app.dart';

import 'package:smart_assist_fyp/models_area3/group.dart' as model;

//! Provider1
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

final currentUserAttributesProvider = FutureProvider<UserModel>((ref) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  UserModel? currentUserData;
  var userDataMap =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  currentUserData = UserModel.fromMap(userDataMap.data()!);

  debugPrint(currentUserData.uid);

  return currentUserData;
});

final currentUserAttributesProvider2 = StateProvider((ref) => null);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  bool _isLoading = false;

  //? ------------------------------------------------------------------------
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //? ------------------------------------------------------------------------

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  //! Method-B For Scrren 2
  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      await auth.signInWithCredential(credential);

      String uid = auth.currentUser!.uid;
      var user = UserModel(
        name: "",
        uid: uid,
        profilePic: "",
        isOnline: true,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );
      await firestore.collection('users').doc(uid).set(user.toMap());

      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  //! Method-A For Scrren 1
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  //! Method-A For Scrren 1
  Future<void> signUpWithEmailAndPassword(BuildContext context,
      String emailAddress, String password, String phoneNumber2) async {
    try {
      debugPrint(
          'Sign UPing  step3 \n $emailAddress \n $password\n $phoneNumber2');

      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      debugPrint("Created account: ${credential.user?.email}");

      if (credential.user != null) {
        String uid = auth.currentUser!.uid;
        debugPrint(uid);

        var user = UserModel(
          name: "",
          uid: uid,
          profilePic: "",
          isOnline: true,
          phoneNumber: phoneNumber2,
          groupId: [],
        );
        //!           email: emailAddress,

        await firestore.collection('users').doc(uid).set(user.toMap());

        debugPrint("Sign uped}");

        // //?await auth.signInWithCredential(credential);
        // await auth.signInWithEmailAndPassword(email: email, password: password);
        debugPrint("Sign in ed with $email  \n $password");

        //! plan B
        Navigator.pushNamed(
          context,
          UserInformationScreen.routeName,
        );

        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   UserInformationScreen.routeName,
        //   (route) => false,
        // );

        //return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // return false;
  }

  Future<bool> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    _isLoading = true;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      debugPrint("Sigin account: ${credential.user?.email}");
      _isLoading = false;
      if (credential.user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
    _isLoading = false;
    return false;
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut();
    //Navigator.popAndPushNamed(context, "/signin");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
      (route) => false,
    );
  }

  //! Method-C For Scrren 3
  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      debugPrint("  $name \n $profilePic  __________________");
      debugPrint(FirebaseStorage.instance.toString());

      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/profilePic%2Flogin_icon.png?alt=media&token=1b5af1ec-4381-44a1-9b1b-e6451539dece';
      debugPrint("Step 1 is ok srart");

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      UserModel? currentUserData;
      var userDataMap = await firestore.collection('users').doc(uid).get();
      currentUserData = UserModel.fromMap(userDataMap.data()!);

      debugPrint("+++++++++++++++++++++++++++++++++++++");
      debugPrint(currentUserData.phoneNumber);


      
      var groupId = const Uuid().v1();

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: currentUserData.phoneNumber,
        groupId: [groupId],
      );
      debugPrint("Step 2 is ok +++++++++++++++++++++++++++++++++++++");

      await firestore.collection('users').doc(uid).set(user.toMap());

      model.Group group = model.Group(
        senderId: auth.currentUser!.uid,
        name: "My Family",
        groupId: groupId,
        lastMessage: '',
        groupPic:
            "https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/systemPic%2Fhome-png-20068.png?alt=media&token=d27c417e-cfa1-47eb-b86d-c0337d540717",
        membersUid: [auth.currentUser!.uid], //[auth.currentUser!.uid, ...uids],
        timeSent: DateTime.now(),
      );

      await firestore.collection('groups').doc(groupId).set(group.toMap());

      debugPrint("Step 3 is ok");

      debugPrint(
          "You are success login but Now restart the app to sync all provider is not lost with context lost");

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
        (route) => false,
      );

      //! Plan B
      // Navigator.pushNamed(
      //   context,
      //   Home.routeName,
      // );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //! Method-A For Scrren 1
  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
