import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features_3_chat_n_gallery/colors.dart';
import '../controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          crossAxisAlignment:
              CrossAxisAlignment.center, //Center Column contents horizontally,
          children: [
            const SizedBox(height: 20),
            const Text(
              'We have sent an SMS with a code.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: TextField(
                //! textAlign
                style: const TextStyle(fontSize: 50), // <-- SEE HERE

                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 60,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
            SizedBox(
              height: 130,
            )
          ],
        ),
      ),
    );
  }
}
