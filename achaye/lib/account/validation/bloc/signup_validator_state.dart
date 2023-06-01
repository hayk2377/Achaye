part of 'signup_validator_bloc.dart';

abstract class SignupValidatorState extends Equatable {
  const SignupValidatorState();
  
  @override
  List<Object> get props => [];
}

class SignupValidatorInitial extends SignupValidatorState {}

class SignupValidatorSuccess extends SignupValidatorState {}

class SignupValidatorDefault extends SignupValidatorState {
  final SignupValidatorError error;
  final TextEditingController email;
  final TextEditingController password;

  SignupValidatorDefault({
    required this.error,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password, error];
}

enum SignupValidatorError { Network, Input, None }
