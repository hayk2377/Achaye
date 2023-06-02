part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchExistingData extends EditProfileEvent{}

class SubmitUpdatedData extends EditProfileEvent{}