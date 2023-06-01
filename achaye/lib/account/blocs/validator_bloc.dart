import 'package:achaye/account/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  AccountRepository accountRepository;
  ValidatorBloc(this.accountRepository) : super(ValidatorInitial()) {
    on<RequestPageLoad>(_generatePage);
    on<AccountCreation>(_goToNextPage);
    on<OnSubmitEvent>(_checkCredentialValidity);
    on<LogoutEvent>(_logout);
  }

  _logout(event, emit) async {
    print("backend being called");
    await this.accountRepository.logOut();
    emit(ValidatorDefault(
        error: ValidatorError.None,
        email: TextEditingController(),
        password: TextEditingController()));
  }

  _checkCredentialValidity(event, emit) async {
    if (state is ValidatorDefault) {
      final _state = state as ValidatorDefault;
      var email = _state.email.text;
      var password = _state.password.text;
      bool loggedIn = await accountRepository.login(email, password);

      if (loggedIn) {
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

  _generatePage(RequestPageLoad event, emit) async {
    bool isLoggedIn = await accountRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(ValidatorSuccess());
    } else {
      emit(ValidatorDefault(
          error: ValidatorError.None,
          email: TextEditingController(),
          password: TextEditingController()));
    }
  }

  _goToNextPage(event, emit) {
    emit(ValidatorAccountCreate());
  }
}
