import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/auth_controller.dart';
import '../repository/auth_repository.dart';
import '/common/utils/colors.dart';
import '/common/utils/utils.dart';
import '/common/widgets/custom_button.dart';
//import '/features/auth/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country == null && phoneNumber.isNotEmpty) {
      ref
          .read(authRepositoryProvider)
          .signInWithPhone(context, '+852$phoneNumber');
    } else if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authRepositoryProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.15),
              const Text('Verifing Your Phone For Create Account or Login.'),
              const SizedBox(height: 25),
              SizedBox(
                width: width * 0.53,
                height: height*0.06,
                child: CustomButton2(
                  onPressed: pickCountry,
                  text: 'Pick Country',
                  
                ),
              ),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  if (country == null) Text('+852'),
                  if (country != null) Text('+${country!.phoneCode}'),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.65,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.1),
              TextButton(
                onPressed: () {
                  sendPhoneNumber();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: height * 0.12,
                    vertical: width * 0.05,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
