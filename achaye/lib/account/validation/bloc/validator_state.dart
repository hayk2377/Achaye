part of 'validator_bloc.dart';

abstract class ValidatorState extends Equatable {
  const ValidatorState();

  @override
  List<Object> get props => [];
}

class ValidatorInitial extends ValidatorState {}

class ValidatorSuccess extends ValidatorState {}

class ValidatorDefault extends ValidatorState {
  final ValidatorError error;
  final TextEditingController email;
  final TextEditingController password;

  ValidatorDefault({
    required this.error,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password, error];
}

enum ValidatorError { Network, Input, None }
