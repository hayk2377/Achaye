import 'package:achaye/account/validation/bloc/validator_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  void handleSubmit(bloc, state) {
    bloc.add(OnSubmitEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ValidatorBloc>();

    return BlocConsumer<ValidatorBloc, ValidatorState>(
      listener: (context, state) {
        if (state is ValidatorSuccess) {
          context.go('/discover');
        }
      },
      builder: (context, state) {
        if (state is ValidatorInitial) {
          bloc.add(RequestPageLoad());
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is ValidatorDefault) {
          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (state.error == ValidatorError.Input)
                        ? Text('Wrong Input')
                        : Container(),
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
                        Column(
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
                                  controller: state.email,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(top: 7, left: 10),
                                  ),
                                ))
                          ],
                        ),
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
                                    controller: state.password,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          top: 14, left: 10),
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(onPress: () {
                          handleSubmit(bloc, state);
                        })
                      ],
                    )),
                  ]),
            ),
          );
        } else if (state is ValidatorSuccess) {
          return Center(
            child: Text('Success!'),
          );
        }

        throw Exception("Bad Validator State");
      },
    );
  }
}
