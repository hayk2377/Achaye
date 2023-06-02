import 'package:achaye/preferences/repository/preferences_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/preferences.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesRepository preferencesRepository;
  PreferencesBloc(this.preferencesRepository) : super(PreferencesInitial()) {
    on<PreferencesInitialEvent>(_changeInitialState);
    on<PreferencesSelectionEvent>(_handleChoices);
    on<ReligionSelectionEvent>(_handleReligionChoice);
    on<PreferenceSubmitEvent>(_handleSubmit);
  }

  _handleSubmit(event, emit) async {
    if (state is PreferencesSelection) {
      final _state = state as PreferencesSelection;

      var preferences = Preferences(
          religiousPreferences: [_state.religionChoice],
          hobbies: _state.choices);

      await preferencesRepository.update(preferences);
    }
  }

  _changeInitialState(event, emit) async {
    List<String> choices = [];
    // Future.delayed(Duration(seconds: 2));
    Preferences preferences = await preferencesRepository.get();
    print(preferences);

    emit(PreferencesSelection(
        choices: preferences.hobbies,
        religionChoice: preferences.religiousPreferences[0]));
  }

  _handleChoices(PreferencesSelectionEvent event, emit) async {
    if (state is PreferencesSelection) {
      final _state = state as PreferencesSelection;
      print("${event.selectedValue} and ${_state.choices}");
      List<String> newChoice = List.of(_state.choices);

      if (_state.choices.contains(event.selectedValue)) {
        newChoice.remove(event.selectedValue);
      } else {
        newChoice.add(event.selectedValue);
      }

      emit(PreferencesSelection(
          choices: newChoice, religionChoice: _state.religionChoice));
    }
  }

  _handleReligionChoice(ReligionSelectionEvent event, emit) {
    if (state is PreferencesSelection) {
      final _state = state as PreferencesSelection;
      print("${event.selectedReligon} and ${_state.religionChoice}");

      emit(PreferencesSelection(
          choices: _state.choices, religionChoice: event.selectedReligon));
    }
  }
}
