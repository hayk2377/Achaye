import 'package:achaye/account/validation/bloc/validator_bloc.dart';
import 'package:achaye/account/widgets/password_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_button.dart';
import 'email_block.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ValidatorBloc>();
    final state = bloc.state;

    void setEmail(String value) {
      setState(() {
        email = value;
      });
    }

    ;

    void setPassword(String value) {
      setState(() {
        password = value;
      });
    }

    ;

    void handleSubmit() {
      print(state);
      bloc.add(OnSubmitEvent(email, password));
      print(state);
      if (state is ValidatorSuccess) {
        context.go('/discover');
      } else {
        print('Try againnnnnnnnnn');
      }
    }

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Sign In",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              child: Column(
            children: [
              EmailBlock(email: setEmail),
              const SizedBox(
                height: 15,
              ),
              PasswordBlock(password: setPassword),
              const SizedBox(
                height: 10,
              ),
              CustomButton(onPress: handleSubmit)
            ],
          )),
        ]),
      ),
    );
  }
}
