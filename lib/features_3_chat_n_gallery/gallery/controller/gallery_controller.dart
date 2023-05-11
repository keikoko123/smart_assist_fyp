import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/controller/chat_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/repository/gallery_repository.dart';
import 'package:smart_assist_fyp/models_area3/photo_model.dart';
import 'package:smart_assist_fyp/models_area3/status_model.dart';

final controller_galleryRepositoryProvider = Provider((ref) {
  final galleryRepository = ref.read(galleryRepositoryProvider);
  return GalleryController(
    galleryRepository: galleryRepository,
    ref: ref,
  );
});

class GalleryController {
  final GalleryRepository galleryRepository;
  final ProviderRef ref;
  GalleryController({
    required this.galleryRepository,
    required this.ref,
  });

  void addPhoto(File file, BuildContext context) {
    galleryRepository.uploadPhoto(
      galleryImage: file,
      context: context,
    );
    // ref.watch(userDataAuthProvider).whenData((value) {
    //   galleryRepository.uploadPhoto(
    //    profilePic: value!.profilePic,
    //     galleryImage: file,
    //     context: context,
    //   );
    // });
  }

  Future<List<String>> getGallery(BuildContext context) async {
    List<String> statuses = await galleryRepository.getGallery(context);
    return statuses;
  }
}
