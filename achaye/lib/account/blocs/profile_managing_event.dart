part of 'profile_managing_bloc.dart';

abstract class ProfileManagingEvent extends Equatable {
  const ProfileManagingEvent();

  @override
  List<Object> get props => [];
}

class RequestProfileData extends ProfileManagingEvent{}

class ProfileLogout extends ProfileManagingEvent{}

class DeleteProfile extends ProfileManagingEvent{}