part of 'profile_managing_bloc.dart';

abstract class ProfileManagingState extends Equatable {
  const ProfileManagingState();

  @override
  List<Object> get props => [];
}

class ProfileManagingInitial extends ProfileManagingState {}

class ProfileManagingLoading extends ProfileManagingState {}

class ProfileManagingLoaded extends ProfileManagingState {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileManagingLoaded(
      {required this.name, required this.email, required this.imageUrl});

  @override
  List<Object> get props => [name, email, imageUrl];
}

class ProfileManagingLogout extends ProfileManagingState {}
class ProfileManagingDeleted extends ProfileManagingState{}