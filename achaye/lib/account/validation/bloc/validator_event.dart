part of 'validator_bloc.dart';

abstract class ValidatorEvent extends Equatable {
  const ValidatorEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitEvent extends ValidatorEvent {
  final String email;
  final String password;

  const OnSubmitEvent(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}
