import 'package:achaye/account/models/user.dart';
import 'package:achaye/account/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late User user;
  AccountRepository accountRepository;
  EditProfileBloc(this.accountRepository) : super(EditProfileInitial()) {
    on<FetchExistingData>(_getExsistingData);
    on<SubmitUpdatedData>(_sendUpdatedData);
  }

  _getExsistingData(event, emit) async {
    //get data here
    //these are dummy datas
    user = await accountRepository.get();
    final String name = user.firstName;
    final String password = user.password;
    final String bio = user.bio;
    final String imageUrl = user.photoUrl!;

    emit(EditProfileDefault(
        nameController: TextEditingController(text: name),
        passwordController: TextEditingController(text: password),
        bioController: TextEditingController(text: bio),
        imageUrl: imageUrl,
        name: name,
        password: password,
        bio: bio));
  }

  _sendUpdatedData(event, emit) async {
    if (state is EditProfileDefault) {
      final _state = state as EditProfileDefault;
      //send the data here I'll just print the data to be sent

      final String name = _state.nameController.text;
      final String password = _state.passwordController.text;
      final String bio = _state.bioController.text;

      user.firstName = name;
      user.password = password;
      user.bio = bio;
      await accountRepository.edit(user);

      emit(EditProfileSuccess());
    }
  }
}
