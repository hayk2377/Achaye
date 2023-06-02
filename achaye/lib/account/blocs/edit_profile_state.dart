part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileDefault extends EditProfileState {
  final String name;
  final String password;
  final String bio;
  final String imageUrl;

  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController bioController;

  EditProfileDefault(
      {required this.nameController,
      required this.imageUrl,
      required this.passwordController,
      required this.bioController,
      required this.name,
      required this.password,
      required this.bio});

  @override
  List<Object> get props => [name, password, bio];
}

class EditProfileError extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}
