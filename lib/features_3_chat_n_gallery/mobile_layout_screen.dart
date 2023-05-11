import 'package:flutter/material.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_1_smarthome/drawer.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/gallery_confirm_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/gallery_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/select_contacts/screens/select_contacts_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/contacts_list.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/ui_constants.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient_theme3,
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    isScrollable: false,
                    controller: tabBarController,
                    indicatorColor: Colors.black,
                    indicatorWeight: 5,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text("CHATS"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text("GALLERY"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsList(),
            GalleryScreen(),
            
            // StatusContactsScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btnX_XXXXX",
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else  if (tabBarController.index == 1){
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                //!!!!!
                Navigator.pushNamed(
                  context,
                  ConfirmPhotoScreen.routeName,
                  arguments: pickedImage,
                );
              }
            }

          },
          backgroundColor: Colors.orangeAccent,
          child:  const Icon(Icons.add, color: Colors.white, size:40),
          // (tabBarController.index == 0)
          // ?const Icon(
          //   Icons.comment,
          //   color: Colors.white,
          // ):const Icon(
          //   Icons.add_to_photos_sharp,
          //   color: Colors.white,
          // ),
          
        ),
      ),
    );
  }
}
