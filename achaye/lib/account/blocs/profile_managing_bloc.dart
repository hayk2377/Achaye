import 'package:achaye/account/account.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_managing_event.dart';
part 'profile_managing_state.dart';

class ProfileManagingBloc
    extends Bloc<ProfileManagingEvent, ProfileManagingState> {
  AccountRepository accountRepository;
  ProfileManagingBloc(this.accountRepository)
      : super(ProfileManagingInitial()) {
    on<RequestProfileData>(_fetchData);
    on<ProfileLogout>(_handleLogout);
    on<DeleteProfile>(_handleProfileDeletion);
  }

  _fetchData(event, emit) async {
    emit(ProfileManagingLoading());
    
    User user = await accountRepository.get();
    String name = user.firstName;
    String email = user.email;
    String imageUrl = user.photoUrl!;

    emit(ProfileManagingLoaded(name: name, email: email, imageUrl: imageUrl));
  }

  _handleLogout(event, emit) async {
    if (state is ProfileManagingLoaded) {
      await accountRepository.logOut();
      emit(ProfileManagingLogout());
    }
  }

  _handleProfileDeletion(event, emit) async {
    if (state is ProfileManagingLoaded) {
      await accountRepository.delete();
      emit(ProfileManagingDeleted());
    }
  }
}
