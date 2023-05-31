part of 'preferences_bloc.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object> get props => [];
}

class PreferencesInitial extends PreferencesState {}

class PreferencesSelection extends PreferencesState {
  final List<String> choices;

  const PreferencesSelection(this.choices);

  @override
  List<Object> get props => [this.choices];
}
