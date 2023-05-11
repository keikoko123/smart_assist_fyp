import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_assist_fyp/app_home.dart';
import 'package:smart_assist_fyp/common/widgets/error.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/login_screen.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/signin_screen.dart';
import 'package:smart_assist_fyp/features_1_smarthome/add_device_controller/add_device_main_screen.dart';
import 'package:smart_assist_fyp/features_1_smarthome/add_device_controller/qr_scanner_screen.dart';
import 'package:smart_assist_fyp/features_2_smartassist/screens/rssi_ble.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/chat/screens/mobile_chat_screen.dart';
import 'package:smart_assist_fyp/features_2_smartassist/screens/orc_read.dart';
import 'package:smart_assist_fyp/features_2_smartassist/screens/phone_call.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/gallery/gallery_confirm_screen.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/community_home.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/select_social_work/screens/select_worker_screen.dart';

import 'features_0_common/auth/screens/otp_screen.dart';
import 'features_0_common/auth/screens/signup_screen.dart';
import 'features_0_common/auth/screens/user_information_screen.dart';
import 'features_3_chat_n_gallery/select_contacts/screens/select_contacts_screen.dart';
import 'features_2_smartassist/screens/calendar_manage.dart';
// import 'dart:io';
// import 'dart:js';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //! area0
    case Home.routeName:
      return MaterialPageRoute(builder: (context) => const Home());




    case ConfirmPhotoScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmPhotoScreen(
          file: file,
        ),
      );

    //! area0
    case SignupScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignupScreen());

    //! area0
    case SigninScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SigninScreen());

    //! area0
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    //! area0
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    //! aera0
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );

    //! area3
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );

    //! 7
    case SelectWorker_Screen.routeName:
          return MaterialPageRoute(
        builder: (context) => const SelectWorker_Screen(),
      );


    case Riss_Ble.routeName:
          return MaterialPageRoute(
        builder: (context) => const Riss_Ble(),
      );

    case QrScanner_Screen2.routeName:
          return MaterialPageRoute(
        builder: (context) => const QrScanner_Screen2(),
      );

    //! area3 chat screen
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          profilePic: profilePic,
        ),
      );
    
    //! area4 community Screen
    case CommunityHome.routeName:
      return MaterialPageRoute(
        builder: (context) => const CommunityHome(),
      );

    //! 7

        case AddDevice.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddDevice(),
      );


    //! 8
    //! 9
    //! 10
    //! 11
    //! 12
    //! 13

    //*  area2 ------
    case Calendar.routeName:
      return MaterialPageRoute(
        builder: (context) => const Calendar(),
      );
    //*  ------
    case Phone_Call.routeName:
      return MaterialPageRoute(
        builder: (context) => const Phone_Call(),
      );

    case Orc_Tech.routeName:
      return MaterialPageRoute(
        builder: (context) => const Orc_Tech(),
      );

    //! X
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesn't exist! Something Wrong!"),
        ),
      );
  }
}
