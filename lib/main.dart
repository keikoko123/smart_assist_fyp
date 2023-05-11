import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/features_0_common/auth/controller/auth_controller.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/user_information_screen.dart';
import 'package:smart_assist_fyp/router.dart';
import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'features_0_common/auth/repository/auth_repository.dart';
import 'firebase_options.dart';
import 'app_home.dart';
import 'landing_screen.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/mobile_layout_screen.dart';
import 'dart:async';

// 



// //! Provider2
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'smart_assist_fyp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!
    
    // final x = ref.watch(userDataAuthProvider);
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Assist',
      //     theme: ThemeData.dark().copyWith(
      // scaffoldBackgroundColor: backgroundColor,
      // appBarTheme: const AppBarTheme(
      //   color: appBarColor,
      // ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange, //here you can give the text color
          elevation: 0,
        ),
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              //return UserInformationScreen();
              return const Home();

              //return const SigninScreen();
              //return const MobileLayoutScreen();
            },
            error: (err, trace) {
              return ErrorScreen(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
