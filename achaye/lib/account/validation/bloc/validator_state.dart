part of 'validator_bloc.dart';

abstract class ValidatorState extends Equatable {
  const ValidatorState();
  
  @override
  List<Object> get props => [];
}

class ValidatorInitial extends ValidatorState {}

class ValidatorSuccess extends ValidatorState{}

class ValidatorFail extends ValidatorState{}

class NetworkError extends ValidatorState{}