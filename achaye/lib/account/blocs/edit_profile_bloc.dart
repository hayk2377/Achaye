import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchExistingData>(_getExsistingData);
    on<SubmitUpdatedData>(_sendUpdatedData);
  }

  _getExsistingData(event, emit) async {
    //get data here
    //these are dummy datas
    await Future.delayed(Duration(seconds: 2));
    final String name = "Sandy";
    final String password = "123456";
    final String bio = "Hey yall howdy dandy";

    emit(EditProfileDefault(
        nameController: TextEditingController(text: name),
        passwordController: TextEditingController(text: password),
        bioController: TextEditingController(text: bio),
        name: name,
        password: password,
        bio: bio));
  }

  _sendUpdatedData(event, emit) {
    if (state is EditProfileDefault) {
      final _state = state as EditProfileDefault;
      //send the data here I'll just print the data to be sent
      print(_state.nameController.text);
      print(_state.passwordController.text);
      print(_state.bioController.text);
    }
  }
}
