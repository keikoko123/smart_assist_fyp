import 'package:flutter/material.dart';
import '/common/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(
          color: blackColor,
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: const Size(double.infinity, 60),
      ),
    );
  }
}



class CustomButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton2({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        minimumSize: const Size(double.infinity, 60),
      ),
    );
  }
}
