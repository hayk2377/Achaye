import 'package:achaye/account/blocs/profile_managing_bloc.dart';
import 'package:achaye/account/blocs/signup_validator_bloc.dart';
import 'package:achaye/account/screens/edit_profile.dart';
import 'package:achaye/account/screens/profile.dart';
import 'package:achaye/account/widgets/sign_up_dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:achaye/account/account.dart';
import 'package:achaye/matching/matching.dart';
import 'package:achaye/preferences/preferences.dart';

import 'account/blocs/edit_profile_bloc.dart';
import 'account/blocs/signup_bloc/signup_bloc.dart';
import 'account/screens/signup_sequence/SlideFour.dart';
import 'account/screens/signup_sequence/SlideImage.dart';
import 'account/screens/signup_sequence/SlideOne.dart';
import 'account/screens/signup_sequence/SlideThree.dart';
import 'account/screens/signup_sequence/SlideTwo.dart';
import 'account/screens/signup_sequence/SlideZero.dart';
import 'matching/widgets/chat.dart';

Map<String, Object> userData = {};

class AchayeApp extends StatelessWidget {
  AccountDataProvider accountDataProvider;
  MatchingDataProvider matchingDataProvider;
  PreferencesDataProvider preferencesDataProvider;

  AchayeApp(
      {required this.accountDataProvider,
      required this.matchingDataProvider,
      required this.preferencesDataProvider,
      super.key});

  final GoRouter _router = GoRouter(routes: [
    GoRoute(path: '/', builder: ((context, state) => Login())),
    GoRoute(path: '/signup', builder: ((context, state) => SlideZero())),
    GoRoute(
      path: '/discover',
      builder: (context, state) => Discover(),
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) => ChatScreen(),
    ),
    GoRoute(
      path: '/chat_list',
      builder: (context, state) => ChatList(),
    ),
    GoRoute(
        path: '/preferences', builder: (context, state) => PreferenceScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(
      path: '/editprofile',
      builder: (context, state) => EditProfile(),
    ),
    GoRoute(
      path: '/pageone',
      builder: (context, state) => SlideOne(
        userData: userData,
      ),
    ),
    GoRoute(
      path: '/pagetwo',
      builder: (context, state) => SlideTwo(userData: userData),
    ),
    GoRoute(
      path: '/pagethree',
      builder: (context, state) => SlideThree(
        userData: userData,
      ),
    ),
    GoRoute(
      path: '/pagefour',
      builder: (context, state) => SlideFour(
        userData: userData,
      ),
    ),
    GoRoute(
      path: '/pageimage',
      builder: (context, state) => SlideImage(
        userData: userData,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AccountRepository>(
            create: (context) => AccountRepository(accountDataProvider),
          ),
          RepositoryProvider<MatchingRepository>(
            create: (context) => MatchingRepository(matchingDataProvider),
          ),
          RepositoryProvider<PreferencesRepository>(
            create: (context) => PreferencesRepository(preferencesDataProvider),
          ),
        ],
        child: MaterialApp(
            home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    SwipingBloc(context.read<MatchingRepository>())),
            BlocProvider(
                create: (context) => SignupValidatorBloc(
                      context.read<AccountRepository>(),
                    )),
            BlocProvider(
                create: (context) =>
                    ValidatorBloc(context.read<AccountRepository>())),
            BlocProvider(create: (context) => ChatListBloc()),
            BlocProvider(
              create: (context) => ChatBloc(),
            ),
            BlocProvider(
                create: (context) =>
                    PreferencesBloc(context.read<PreferencesRepository>())),
            BlocProvider(
                create: (context) => SignupBloc(context.read<AccountRepository>()))
                    // SignupBloc(context.read<AccountRepository>())),
          ],
          child: MaterialApp.router(
            routerConfig: _router,
          ),
        )));
  }
}
