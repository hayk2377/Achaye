import 'package:achaye/account/validation/bloc/signup_validator_bloc.dart';
import 'package:achaye/account/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Replacable dummy sign up"),
      ),
      body: SignUpAccountPage(),
    );
  }
}

class SignUpAccountPage extends StatelessWidget {
  const SignUpAccountPage({super.key});

  void _handleSubmit(bloc, state) {
    bloc.add(ButtonAccountCreation());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupValidatorBloc>();

    bloc.add(InitialPage());

    return BlocConsumer<SignupValidatorBloc, SignupValidatorState>(
      listener: (context, state) {
        if (state is SignupValidatorSuccess) {
          context.go('/');
        }
      },
      builder: (context, state) {
        if (state is SignupValidatorSuccess) {
          return Center(
            child: Text("Successfully signed up"),
          );
        } else if (state is SignupValidatorInitial) {
          bloc.add(InitialPage());
          return Container();
        } else if (state is SignupValidatorDefault) {
          return Column(
            children: [
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: TextFormField(
                        controller: (state as SignupValidatorDefault).email,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 7, left: 10),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: TextFormField(
                              controller:
                                  (state as SignupValidatorDefault).password,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(top: 14, left: 10),
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(onPress: () {
                    _handleSubmit(bloc, state);
                  })
                ],
              ))
            ],
          );
        }
        throw Exception("Unhandled state ${state}");
      },
    );
  }
}
