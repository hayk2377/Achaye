part of 'signup_validator_bloc.dart';

abstract class SignupValidatorEvent extends Equatable {
  const SignupValidatorEvent();

  @override
  List<Object> get props => [];
}

class InitialPage extends SignupValidatorEvent {}
class ButtonAccountCreation extends SignupValidatorEvent {}