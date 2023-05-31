import 'package:achaye/account/validation/bloc/validator_bloc.dart';
import 'package:achaye/matching/chat_list/chat_bloc/chat_bloc.dart';
import 'package:achaye/preferences/widgets/preferences.dart';
import 'package:achaye/suggestions/swiping/bloc/swiping_bloc.dart';
import 'package:achaye/suggestions/widgets/discover_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

import 'account/screen/login_screen.dart';
import 'matching/chat_list/widgets/chat_list.dart';

class AchayeApp extends StatelessWidget {
  const AchayeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(routes: [
      GoRoute(path: '/s', builder: ((context, state) => Login())),
      GoRoute(path: '/', builder: (context, state) => Discover(),),
      GoRoute(path: '/chat_list', builder: (context, state) => ChatList(),),
      GoRoute(path: '/preferences', builder: (context, state) => PreferenceScreen()),
    ]);
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: ((context) => SwipingBloc())),
        BlocProvider(create: ((context) => ChatBloc())),
        BlocProvider(create: (context) => ValidatorBloc(),)
      ], 
      child: MaterialApp.router(routerConfig: _router,),
      )
    );
  }
}
