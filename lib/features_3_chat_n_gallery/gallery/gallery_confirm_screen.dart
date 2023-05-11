import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/controller/gallery_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/repository/gallery_repository.dart';

import 'gallery_screen.dart';

class ConfirmPhotoScreen extends ConsumerWidget {
  static const String routeName = '/confirm-status-screen';
  final File file;
  const ConfirmPhotoScreen({
    Key? key,
    required this.file,
  }) : super(key: key);

  void addPhoto(WidgetRef ref, BuildContext context) {
    debugPrint('STEP 1 OK ');
    ref.read(controller_galleryRepositoryProvider).addPhoto(file, context);
            // Navigator.pushNamed(context, GalleryScreen.routeName);
    //ref.read(controller_galleryRepositoryProvider).refreash;
    ref.invalidate(galleryRepositoryProvider);
    ref.read(controller_galleryRepositoryProvider).getGallery(context);
    
    Navigator.pop(context);
  
   // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
       // onPressed: (){},
       
        onPressed: () => addPhoto(ref, context),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
