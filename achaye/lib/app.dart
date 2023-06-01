import 'package:achaye/account/validation/bloc/validator_bloc.dart';
import 'package:achaye/account/widgets/profile.dart';
import 'package:achaye/matching/chat_list/chat_bloc/chat_list_bloc.dart';
import 'package:achaye/matching/end_to_end_chat/bloc/chat_bloc.dart';
import 'package:achaye/matching/end_to_end_chat/widgets/chat.dart';
import 'package:achaye/preferences/preferences_bloc/preferences_bloc.dart';
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
      GoRoute(path: '/discover', builder: (context, state) => Discover(),),
      GoRoute(path: '/chats', builder: (context, state) => ChatScreen(),),
      GoRoute(path: '/chat_list', builder: (context, state) => ChatList(),),
      GoRoute(path: '/preferences', builder: (context, state) => PreferenceScreen()),
      GoRoute(path: '/', builder: (context, state) => ProfileScreen()),

    ]);
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => SwipingBloc()),
        BlocProvider(create: (context) => ChatListBloc()),
        BlocProvider(create: (context) => ValidatorBloc(),),
        BlocProvider(create: (context) => ChatBloc(),),
        BlocProvider(create: (context) => PreferencesBloc())
      ], 
      child: MaterialApp.router(routerConfig: _router,),
      )
    );
  }
}
