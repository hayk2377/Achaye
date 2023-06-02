import 'package:achaye/account/repository/account_repository.dart';
import 'package:bloc/bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AccountRepository accountRepository;
  SignupBloc(this.accountRepository) : super(SignupInitial()) {
    on<SendDataToServer>((event, emit) {
      print("Data: ${event.userData}");
      emit(SignupSuccess());
    });
  }
}
