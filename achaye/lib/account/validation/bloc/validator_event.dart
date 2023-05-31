part of 'validator_bloc.dart';

abstract class ValidatorEvent extends Equatable {
  const ValidatorEvent();

  @override
  List<Object> get props => [];
}

class RequestPageLoad extends ValidatorEvent {}
class OnSubmitEvent extends ValidatorEvent {}
