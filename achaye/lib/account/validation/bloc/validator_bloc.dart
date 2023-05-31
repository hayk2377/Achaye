import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorInitial()) {
    on<OnSubmitEvent>(_checkCredentialValidity);
  }

  _checkCredentialValidity(event, emit) {
    String name = "a@a.com";
    String password = "12345678";

    final _event = event as OnSubmitEvent;

    if (_event.email == name && _event.password == password) {
      print('login successful');
      emit(ValidatorSuccess());
    } else {
      print('Incorrect Email or Password');
    }
  }
}
