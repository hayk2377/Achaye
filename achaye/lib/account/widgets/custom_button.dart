import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;

  CustomButton({required this.onPress});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(onPressed: onPress, child: const Text('Login')),
    );
  }
}