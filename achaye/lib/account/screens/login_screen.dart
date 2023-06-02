import 'package:achaye/account/blocs/validator_bloc.dart';
import 'package:achaye/account/repository/account_repository.dart';
import 'package:achaye/account/widgets/custom_widget_background.dart';
import 'package:achaye/account/widgets/login_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ValidatorBloc(context.read<AccountRepository>()),
        child: Scaffold(
          body: Stack(
            children: [CustomWidgetBackground(), LoginForm()],
          ),
        ));
  }
}
