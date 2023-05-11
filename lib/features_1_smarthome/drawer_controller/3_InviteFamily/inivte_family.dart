import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/QRscanner/barcode_scanner_window.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/controller/group_controller.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/QRscanner/qr_scanner_screen.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer_controller/2_relationship/group/widgets/select_contacts_group.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/models_area3/user_model.dart';

class Invite_Family extends ConsumerStatefulWidget {
  const Invite_Family({super.key});
  static const String routeName = '/inivte-Family';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Invite_FamilyState();
}

class _Invite_FamilyState extends ConsumerState<Invite_Family> {
  final TextEditingController groupNameController = TextEditingController();
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }


  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Future<UserModel?> user = ref.read(authControllerProvider).getUserData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relationship Invitation'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.07),

            FutureBuilder<UserModel?>(
              future: user,
              builder: (BuildContext context, AsyncSnapshot<UserModel?>  snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return QrImage(
                      data: snapshot.data!.groupId[0],
                      version: QrVersions.auto,
                      size: 250,
                      gapless: false,
                    );
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),

            // QrImage(
            //   data: uid,
            //   version: QrVersions.auto,
            //   size: 250,
            //   gapless: false,
            // ),

            // Container(
            //   alignment: Alignment.topLeft,
            //   padding: const EdgeInsets.all(8),
            //   child: const Text(
            //     'Select Contacts',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            // const SelectContactsGroup(),
            const SizedBox(height: 10),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: const Text(
                'Invite Your Family!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: height * 0.07),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QrScanner_Screen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: height * 0.06,
                  vertical: width * 0.07,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'SCAN  NOW  !',
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
