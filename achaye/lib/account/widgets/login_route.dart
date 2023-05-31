import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? _passwordVisible = false;

  Widget buildEmailBlock() {
    return Column(
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
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 7, left: 10),
              ),
            ))
      ],
    );
  }

  Widget buildPasswordBlock() {
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
                obscureText: !_passwordVisible!,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 14, left: 10),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible!
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible!;
                      });
                    },
                  ),
                )))
      ],
    );
  }

  Widget buildLoginBtn() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            context.go('/discover');
          },
          child: const Text('Login')),
    );
  }

  Widget buildBackgroundColor() {
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

  Widget buildFormBlock() {
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
              buildEmailBlock(),
              const SizedBox(
                height: 15,
              ),
              buildPasswordBlock(),
              const SizedBox(
                height: 10,
              ),
              buildLoginBtn()
            ],
          )),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [buildBackgroundColor(), buildFormBlock()],
      ),
    );
  }
}
