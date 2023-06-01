import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import '../repository/account_repository.dart';

part 'signup_validator_event.dart';
part 'signup_validator_state.dart';

class SignupValidatorBloc
    extends Bloc<SignupValidatorEvent, SignupValidatorState> {
  AccountRepository accountRepository;
  SignupValidatorBloc(this.accountRepository)
      : super(SignupValidatorInitial()) {
    on<InitialPage>(_loadPage);
    on<ButtonAccountCreation>(_checkSignupValidity);
  }

  _loadPage(event, emit) {
    emit(SignupValidatorDefault(
        error: SignupValidatorError.None,
        email: TextEditingController(),
        password: TextEditingController()));
  }

  _checkSignupValidity(event, emit) async {
    User user = User(
      firstName: "Abebe",
      lastName: "Kebede",
      birthday: "8/8/8",
      email: (state as SignupValidatorDefault).email.text,
      password: (state as SignupValidatorDefault).password.text,
      sex: "male",
      religion: "abc",
      bio: "lorem lorem",
      imageFilePath: null,
      religiousPreferences: ["abc"],
      hobbies: ["abc", "cde"],
    );

    try {
      User returnedUser = await accountRepository.signup(user);
      emit(SignupValidatorSuccess());
    } catch (e) {
      emit(SignupValidatorDefault(
          error: SignupValidatorError.Input,
          email: TextEditingController(),
          password: TextEditingController()));
    }
  }
}
