import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(PreferencesInitial()) {
    on<PreferencesInitialEvent>(_changeInitialState);
    on<PreferencesSelectionEvent>(_handleChoices);
  }

  _changeInitialState(event, emit) async{
    List<String> choices = [];
    await Future.delayed(Duration(seconds: 2));

    emit(PreferencesSelection(choices));
  }

  _handleChoices(PreferencesSelectionEvent event, emit) async{
    if (state is PreferencesSelection) {
      final _state = state as PreferencesSelection;
      print("${event.selectedValue} and ${_state.choices}");
      List<String> newChoice = List.of(_state.choices);

      if (_state.choices.contains(event.selectedValue)) {
        newChoice.remove(event.selectedValue);
      } else {
        newChoice.add(event.selectedValue);
      }

      emit(PreferencesSelection(newChoice));
    }
  }
}
