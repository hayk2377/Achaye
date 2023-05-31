import 'package:flutter/material.dart';

class CustomWidgetBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xFFFC936D),
            Color(0xFFFB8E67),
            Color(0xFFFF7F50),
            Color(0xFFFA6B37)
          ],
              stops: [
            0.1,
            0.4,
            0.7,
            0.9
          ])),
    );
  }
}