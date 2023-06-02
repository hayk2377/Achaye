part of 'preferences_bloc.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object> get props => [];
}

class PreferencesInitial extends PreferencesState {}

class PreferencesSelection extends PreferencesState {
  final List<String> choices;
  final String religionChoice;

  const PreferencesSelection(
      {required this.choices, required this.religionChoice});

  @override
  List<Object> get props => [choices, religionChoice];
}
