import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_assist_fyp/features_0_common/auth/screens/login_screen.dart';

import 'widgets/centred_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features_3_chat_n_gallery/colors.dart';
import '../controller/auth_controller.dart';

var formKey = GlobalKey<FormState>();
String email = "", password = "";
bool isChecked = false;
bool isVisible = false;

extension EmailValidation on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});
  static const String routeName = '/SigninScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  
  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height*0.07,
                  ),
                  // const Text(
                  //   'Sign in with your email and password \nor continue with social media',
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     height: 1.5,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (String? newValue) {
                      email = newValue!;
                    },
                    validator: (String? value) {

                      if (!value!.isValidEmail()) {
                        return "Not valid, format must be: abc@gmail.com";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      labelText: "Email",
                      hintText: "Enter your email",
                      suffixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: !isVisible,
                    onSaved: (String? newValue) {
                      password = newValue!;
                    },
                    validator: (String? value) {
                      if (value!.length < 8) {
                        return "Password Length must be longer than 8";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      labelText: "Password",
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          isVisible = !isVisible;
                          setState(() {});
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          // Checkbox(
                          //   value: isChecked,
                          //   onChanged: changeCheckboxState,
                          // ),
                          StatefulCheckBox(),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                                            formKey.currentState!.save();

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black87 ,// const Color(0xfff77546),
                      foregroundColor: Colors.white,
                   //   padding: EdgeInsets.only(top: 20,  bottom: 20,left: 100, right: 100, ),
                      padding: EdgeInsets.symmetric(
                        horizontal: height*0.105,  
                        vertical: width*0.05,                     
                        // horizontal: 100,  
                        // vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Email Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Text('OR'),
                  SizedBox(
                    height: 15,
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding:  EdgeInsets.symmetric(
                        horizontal: height*0.105,  
                        vertical: width*0.05,  
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Phone Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        // padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffeeeff1),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/icons/google.svg",
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffeeeff1),
                        ),
                        child: Image.asset("assets/icons/facebook.png"),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(9),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffeeeff1),
                        ),
                        child: Image.asset("assets/icons/twitter.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CentredRow(
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/SignupScreen");
                        },
                        child: const Text(
                          ' Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),


                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Don\'t have an account? ',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     Text(
                  //       'Sign Up',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.orange,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(context, ref) async {
    // if (formKey.currentState!.validate()) {
    //   formKey.currentState!.save();
    //   debugPrint(email);
    //   debugPrint(password);
    //   debugPrint(isChecked.toString());
    //   // call sign in API
    //   bool isSuccess = await authController.signIn(email, password);
    //   // if success
    //   // go to home screen
    //   if (isSuccess) {
    //     Navigator.pushReplacementNamed(context, "/home");
    //   } else {
    //     debugPrint("Sigin faild");
    //   }
    // }
  }

  void changeCheckboxState(bool? value) {
    debugPrint('changeCheckboxState: $value');
    isChecked = value!;
  }
}

class StatefulCheckBox extends StatefulWidget {
  const StatefulCheckBox({super.key});

  @override
  State<StatefulCheckBox> createState() => _StatefulCheckBoxState();
}

class _StatefulCheckBoxState extends State<StatefulCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: changeCheckboxState,
    );
  }

  void changeCheckboxState(bool? value) {
    isChecked = value!;
    setState(() {});
  }
}
