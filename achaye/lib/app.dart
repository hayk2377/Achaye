import 'package:achaye/account/widgets/login_route.dart';
import 'package:achaye/matching/chat_list/chat_bloc/chat_bloc.dart';
import 'package:achaye/suggestions/swiping/bloc/swiping_bloc.dart';
import 'package:achaye/suggestions/widgets/discover_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

import 'matching/chat_list/widgets/chat_list.dart';

class AchayeApp extends StatelessWidget {
  const AchayeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(routes: [
      GoRoute(path: '/', builder: ((context, state) => Login())),
      GoRoute(path: '/discover', builder: (context, state) => Discover(),),
      GoRoute(path: '/chat_list', builder: (context, state) => ChatList(),)
    ]);
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: ((context) => SwipingBloc())),
        BlocProvider(create: ((context) => ChatBloc())),
      ], 
      child: MaterialApp.router(routerConfig: _router,),
      )
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

Future<Map<String, String>> tryGet() async {
  var response = await http.get(Uri.parse("https://localhost:3000"));
  print("--------response is -----------");
  print(response);
  return jsonDecode(response.body);
}

class _DummyState extends State<Dummy> {
  Map? reply;

  @override
  void initState() {
    tryGet().then((map) => setState(() {
          reply = map;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('reply');
  }
}
