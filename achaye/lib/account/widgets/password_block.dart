import 'package:flutter/material.dart';

class PasswordBlock extends StatelessWidget {
  final ValueChanged<String> password;

  PasswordBlock({required this.password, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: TextFormField(
                onChanged: password,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 14, left: 10),
                )))
      ],
    );
  }
}
