import 'package:flutter/material.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/login_screen.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/signin_screen.dart';
import '/common/utils/colors.dart';
import '/common/widgets/custom_button.dart';

//import '/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    //Navigator.pushNamed(context, LoginScreen.routeName);
    Navigator.pushNamed(context, SigninScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Text(
              'Welcome to Smart Assist',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: size.height / 30),
            Image.asset(
              'assets/bg.png',
              height: 320,
              width: 320,
               // color: Colors.orange,
              
            ),
            SizedBox(height: size.height / 15),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: greyColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.9,
              child: CustomButton(
                text: 'AGREE & CONTINUE',
                
                
                onPressed: () => navigateToLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
