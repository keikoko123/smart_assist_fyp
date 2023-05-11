import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/centred_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features_3_chat_n_gallery/colors.dart';
import '../controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var formKey = GlobalKey<FormState>();
String email = "", password = "", passwordConfirmation = "", phoneNumber = "";

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  static const String routeName = '/SignupScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: Colors.grey,
                          )),
                      const Text(
                        'Register Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Multi",
                        ),
                      ),
                      const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Complete your details',
                    style: TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (String? newValue) {
                      email = newValue!;
                    },
                    validator: (String? value) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (!emailValid) {
                        return "Email not valid";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      suffixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    onSaved: (String? newValue) {
                      phoneNumber = newValue!;
                    },
                    validator: (String? value) {
                      if (value!.length < 8) {
                        return "Password Length must be longer than 8";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter your Phone Number",
                      suffixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    onSaved: (String? newValue) {
                      password = newValue!;
                    },
                    validator: (String? value) {
                      if (value!.length < 8) {
                        return "The lengh is < 8";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      suffixIcon: const Icon(Icons.lock_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    onSaved: (String? newValue) {
                      passwordConfirmation = newValue!;
                    },
                    validator: (String? value) {
                      if (value!.length < 8) {
                        return "The lengh is < 8";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Re-enter your password",
                      suffixIcon: const Icon(Icons.lock_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 29,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {


                        formKey.currentState!.save();
                        debugPrint(
                            'Sign UPing  step1 \n $email --- \n $password --\n $phoneNumber  --');
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ref
                            .read(authControllerProvider)
                            .signUpWithEmailAndPassword(
                                context, email, password, phoneNumber);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xfff77546),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 110,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(context, AuthController authController) async {
    // if (formKey.currentState!.validate()) {
    //   formKey.currentState!.save();
    //   debugPrint(email);
    //   debugPrint(password);
    //   debugPrint(passwordConfirmation);
    //   // call sign up API
    //   bool isSuccess = await authController.signUp(email, password);
    //   // if success
    //   // go to home screen
    //   if (isSuccess) {
    //     Navigator.pushReplacementNamed(context, "/home");
    //   } else {
    //     debugPrint("Sigup faild");
    //   }
    // }
  }
}
