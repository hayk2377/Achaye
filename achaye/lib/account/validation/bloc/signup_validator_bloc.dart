import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'signup_validator_event.dart';
part 'signup_validator_state.dart';

class SignupValidatorBloc
    extends Bloc<SignupValidatorEvent, SignupValidatorState> {
  SignupValidatorBloc() : super(SignupValidatorInitial()) {
    on<InitialPage>(_loadPage);
    on<ButtonAccountCreation>(_checkSignupValidity);
  }

  _loadPage(event, emit) {
    emit(SignupValidatorDefault(
        error: SignupValidatorError.None,
        email: TextEditingController(),
        password: TextEditingController()));
  }

  _checkSignupValidity(event, emit) {
    //this is where logic check is handled...if the account already exsists or not
    //if the data is sent or not
    emit(SignupValidatorSuccess());
  }
}
