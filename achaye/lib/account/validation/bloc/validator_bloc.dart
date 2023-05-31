import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorInitial()) {
    on<RequestPageLoad>(_generatePage);
    on<OnSubmitEvent>(_checkCredentialValidity);
  }

  _checkCredentialValidity(event, emit) {
    if (state is ValidatorDefault) {
      String name = "a@a.com";
      String password = "12345678";

      final _state = state as ValidatorDefault;
      if (_state.email.text == name && _state.password.text == password) {
        print('login successful');
        emit(ValidatorSuccess());
      } else {
        emit(ValidatorDefault(
            error: ValidatorError.Input,
            email: _state.email,
            password: _state.password));
        print('Incorrect Email or Password');
      }
    }
  }

  _generatePage(RequestPageLoad event, emit) {
    emit(ValidatorDefault(
        error: ValidatorError.None,
        email: TextEditingController(),
        password: TextEditingController()));
  }
}
