part of 'profile_managing_bloc.dart';

abstract class ProfileManagingState extends Equatable {
  const ProfileManagingState();
  
  @override
  List<Object> get props => [];
}

class ProfileManagingInitial extends ProfileManagingState {}
