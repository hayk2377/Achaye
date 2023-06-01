import 'package:achaye/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OptionsDialog extends StatelessWidget {
  const OptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ValidatorBloc>();
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (value) {
        context.push(value);
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            child: Text("Edit Preference"),
            value: '/preferences',
          ),
          PopupMenuItem<String>(
            child: Text("Edit Profile"),
            value: '/profile',
          ),
          PopupMenuItem<String>(
            child: Text("Logout"),
            value: '/',
          ),
        ];
      },
    );
  }
}
