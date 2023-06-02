import 'package:achaye/account/blocs/signup_validator_bloc.dart';
import 'package:achaye/account/widgets/sign_up_dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:achaye/account/account.dart';
import 'package:achaye/matching/matching.dart';
import 'package:achaye/preferences/preferences.dart';

import 'account/blocs/edit_profile_bloc.dart';
import 'account/widgets/edit_profile.dart';
import 'account/widgets/profile.dart';
import 'matching/widgets/chat.dart';

// import 'package:achaye/account/validation/bloc/validator_bloc.dart';
// import 'package:achaye/account/widgets/profile.dart';
// import 'package:achaye/matching/widgets/chat.dart';
// import 'package:achaye/preferences/preferences_bloc/preferences_bloc.dart';
// import 'package:achaye/preferences/repository/preferences_repository.dart';
// import 'package:achaye/preferences/widgets/preferences.dart';

// import 'account/screen/login_screen.dart';

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
    GoRoute(path: '/signup', builder: ((context, state) => SignUpAccount())),
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
    )
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
            BlocProvider(create: (context) => ChatListBloc()),
            BlocProvider(
              create: (context) =>
                  ValidatorBloc(context.read<AccountRepository>()),
            ),
            BlocProvider(
              create: (context) => ChatBloc(),
            ),
            BlocProvider(create: (context) => PreferencesBloc()),
            BlocProvider(create: (context) => EditProfileBloc())

          ],
          child: MaterialApp.router(
            routerConfig: _router,
          ),
        )));
  }
}
