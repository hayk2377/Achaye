part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SendDataToServer extends SignupEvent{
  final Map<String, Object> userData;

  SendDataToServer({required this.userData});
}
