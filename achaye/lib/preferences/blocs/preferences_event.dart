// ignore_for_file: must_be_immutable

part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];
}

class PreferencesInitialEvent extends PreferencesEvent {}

class PreferencesSelectionEvent extends PreferencesEvent {
  final String selectedValue;
  PreferencesSelectionEvent(this.selectedValue);

   @override
  List<Object> get props => [selectedValue];
}

class ReligionSelectionEvent extends PreferencesEvent {
  final String selectedReligon;

  ReligionSelectionEvent(this.selectedReligon);

   @override
  List<Object> get props => [selectedReligon];

}
