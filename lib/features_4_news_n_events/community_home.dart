import 'package:flutter/material.dart';
import 'package:smart_assist_fyp/common/utils/utils.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/colors.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/gallery_confirm_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/select_contacts/screens/select_contacts_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/widgets/contacts_list.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_assist_fyp/features_4_news_n_events/events_page.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/news_page.dart';
import 'package:smart_assist_fyp/common/ui_constants.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/select_social_work/screens/select_worker_screen.dart';

class CommunityHome extends ConsumerStatefulWidget {
  static const String routeName = '/CommunityHome';

  const CommunityHome({Key? key}) : super(key: key);
  @override
  ConsumerState<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends ConsumerState<CommunityHome>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController_area4;
  @override
  void initState() {
    super.initState();
    tabBarController_area4 = TabController(length: 2, vsync: this);
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
                    controller: tabBarController_area4,
                    indicatorColor: Colors.black,
                    indicatorWeight: 5,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                    tabs: const [
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Text("NEWS"),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Text("EVENT"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabBarController_area4,
          children: const <Widget>[
            NewsPage(),
            EventPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btnX_area4444",
          onPressed: () async {
              Navigator.pushNamed(context, SelectWorker_Screen.routeName);

          },
          backgroundColor: Colors.orangeAccent,
          child: const Icon(
            Icons.waving_hand,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
