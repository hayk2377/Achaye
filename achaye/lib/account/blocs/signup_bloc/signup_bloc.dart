import 'package:achaye/account/repository/account_repository.dart';
import 'package:bloc/bloc.dart';

import '../../models/user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AccountRepository accountRepository;
  SignupBloc(this.accountRepository) : super(SignupInitial()) {
    on<SendDataToServer>((event, emit) async {
      print("Data: ${event.userData}");
      User user = User.fromMap(event.userData);
      await accountRepository.signup(user);
      print("signed up!");
      emit(SignupSuccess());
    });
  }
}
