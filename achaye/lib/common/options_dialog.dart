import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionsDialog extends StatelessWidget {
  const OptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Text("Profile"),
            value: '/profile',
          ),
        ];
      },
    );
  }
}
