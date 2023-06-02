import 'package:acha/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SlideFourPage extends StatelessWidget {
  SlideFourPage({super.key, required this.userData});
  Map<String, Object> userData;
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignupBloc>();
    final state = bloc.state;

    return BlocConsumer<SignupBloc, SignupState>(builder: ((context, state) {
      if (state is SignupSuccess){
        return const Center(child: Text("Success"),);
      }
      else if (state is SignupInitial){
        return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Step 4: Congratulations!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'You are done with the signup process!',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              SizedBox(width: 10,),
            ElevatedButton(
            onPressed:()=> context.go('/pageimage'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFF7F50)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: const Text('previous'),
            ),
            ElevatedButton(
            onPressed: () {
              bloc.add(SendDataToServer(userData: userData));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: const Text('Submit'),
            ),
            const SizedBox(width: 10,)
            ]),
        ],
      );
      }
      throw Exception("Unhandled state $state");

    }), listener: ((context, state) {
      if (state is SignupSuccess){
        context.go('/pageone');
      }
    }));
  }
}

class SlideFour extends StatelessWidget {
  const SlideFour({
    super.key,
    required this.userData,
  });

  final Map<String, Object> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: const Color(0xFFFF7F50),
      ),
      body: SlideFourPage(userData: userData,)
    );
  }
}
