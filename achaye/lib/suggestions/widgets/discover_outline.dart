import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackgroundCurveWidget extends StatelessWidget {
  const BackgroundCurveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 250,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64),
                  bottomRight: Radius.circular(64))),
          gradient:
              LinearGradient(colors: [Color(0xFFFF7F50), Color(0xFFFA6B37)]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discover',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 36),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.go('/chat_list');
                          },
                          icon: const Icon(Icons.chat_bubble_outline_rounded,
                              color: Colors.white, size: 36)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.person, color: Colors.white, size: 36,),)
                    ],
                  ))
            ],
          ),
        ));
  }
}
