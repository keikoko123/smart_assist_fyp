import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/controller/group_controller.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/widgets/select_contacts_group.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';

class EditProfile extends ConsumerStatefulWidget {
  static const String routeName = '/edit_profile';

  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final TextEditingController nameInputController = TextEditingController();

  File? image;
  final controller1 = TextEditingController();

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void createGroup() {
    if (nameInputController.text.trim().isNotEmpty && image != null) {
//!!!!!!!!!!!!!!!!
      // ref.read(groupRepositoryProvider).createGroup(
      //       context,
      //       groupNameController.text.trim(),
      //       image!,
      //       ref.read(selectedGroupContacts),
      //     );

      ref.read(groupControllerProvider).createGroup(
            context,
            nameInputController.text.trim(),
            image!,
            ref.read(selectedGroupContacts),
          );
      ref.read(selectedGroupContacts.notifier).update((state) => []);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameInputController.dispose();
  }

  void saveData(String nameInput) {
    ref
        .read(authControllerProvider)
        .saveUserDataToFirebase(context, nameInput, image);

    ref.refresh(currentUserAttributesProvider);

    // Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final myUserData = ref.watch(currentUserAttributesProvider);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile '),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                image == null
                    ? CircleAvatar(
                        radius: 80,

                        backgroundImage: myUserData.when(data: (user) {
                          return NetworkImage(user.profilePic);
                        }, error: (err, trace) {
                          return NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/systemPic%2Flogin_icon.png?alt=media&token=3368beaa-c0b4-434b-a539-5b680d997e44");
                        }, loading: () {
                          return NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/smart-assist-fyp.appspot.com/o/systemPic%2Flogin_icon.png?alt=media&token=3368beaa-c0b4-434b-a539-5b680d997e44");
                        }),

                        //Image.network(),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          image!,
                        ),
                        radius: 80,
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 45,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: nameInputController,
                decoration: const InputDecoration(
                  hintText: 'Edit Your Name',
                ),
              ),
            ),
            // SizedBox(
            //   height: 25,
            // ),
            TextButton(
              onPressed: () {
                String nameInput = nameInputController.text.trim();

                saveData(nameInput);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: height * 0.105,
                  vertical: width * 0.05,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
