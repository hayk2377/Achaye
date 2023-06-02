import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(PreferencesInitial()) {
    on<PreferencesInitialEvent>(_changeInitialState);
    on<PreferencesSelectionEvent>(_handleChoices);
    on<ReligionSelectionEvent>(_handleReligionChoice);
  }

  _changeInitialState(event, emit) async {
    List<String> choices = [];
    String religionChoice = "Protestant";
    await Future.delayed(Duration(seconds: 2));

    emit(
        PreferencesSelection(choices: choices, religionChoice: religionChoice));
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
