// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';

import '../../../models_area3/user_model.dart';

//! Provider1
final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});


// //! Provider2
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});



class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signUpWithEmailAndPassword(BuildContext context, String email, String password, String phoneNumber){
      debugPrint('Sign UPing  step2 \n $email --- \n $password --\n $phoneNumber');

    authRepository.signUpWithEmailAndPassword(context, email, password, phoneNumber);

  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

//? method2
  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  //?method3
  void saveUserDataToFirebase( BuildContext context, String name, File? profilePic) {
    
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  // //?method4
  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }

}

