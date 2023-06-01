import 'package:achaye/account/widgets/custom_widget_background.dart';
import 'package:achaye/account/widgets/login_route.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [CustomWidgetBackground(), LoginForm()],
      ),
    );
  }
}
