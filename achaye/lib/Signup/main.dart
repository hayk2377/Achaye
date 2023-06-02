// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';

// import '../account/blocs/bloc/signup_bloc.dart';
// import 'SlideFour.dart';
// import 'SlideImage.dart';
// import 'SlideOne.dart';
// import 'SlideThree.dart';
// import 'SlideTwo.dart';
// import 'SlideZero.dart';


// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App',
//       home: SignupPage(),
//     );
//   }
// }

// class SignupPage extends StatelessWidget {
//   SignupPage({super.key});

//     @override
//    Widget build(BuildContext context) {
//     final GoRouter myrout=GoRouter(routes: [
//       GoRoute(path: '/',builder: (context, state) => SlideZero(),),
//       GoRoute(path: '/pageone',builder: (context, state) => SlideOne(userData: userData,),),
//       GoRoute(path: '/pagetwo',builder: (context, state) => SlideTwo(userData:userData),),
//       GoRoute(path: '/pagethree',builder: (context, state) => SlideThree(userData: userData,),),
//       GoRoute(path: '/pagefour',builder: (context, state) => SlideFour(userData: userData,),),
//       GoRoute(path: '/pageimage',builder: (context, state) => SlideImage(userData: userData,),),

//     ]);
//     // return MultiBlocProvider(
//     //   providers: [
//     //     BlocProvider(
//     //       create: (context) => SignupBloc(),
//     //     ),
//     //   ],
//     //   child: MaterialApp.router(
//     //   routerConfig: myrout,
//     // ),
//     // );
//     return MaterialApp(
//       home: MultiBlocProvider(providers: [
//         BlocProvider(create: (context)=> SignupBloc()),
//       ], child: MaterialApp.router(
//         routerConfig: myrout,
//       ),),
//     );
//   }
//   Map<String, Object> userData = {};

// }




