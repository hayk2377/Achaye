import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_managing_event.dart';
part 'profile_managing_state.dart';

class ProfileManagingBloc extends Bloc<ProfileManagingEvent, ProfileManagingState> {
  ProfileManagingBloc() : super(ProfileManagingInitial()) {
    on<ProfileManagingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
