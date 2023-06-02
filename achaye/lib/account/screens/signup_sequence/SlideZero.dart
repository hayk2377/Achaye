import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SlideZero extends StatelessWidget {
  SlideZero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7F50),
        title: const Text(
          'SignUP',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome To Achaye',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            const Text(
              'Your dating app for meaningful connections.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/pageone'),
              style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF7F50)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
