// ignore_for_file: must_be_immutable

part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];
}

class PreferencesSelectionEvent extends PreferencesEvent {
  String selectedValue;
  PreferencesSelectionEvent(this.selectedValue);
}

class PreferencesInitialEvent extends PreferencesEvent {}
