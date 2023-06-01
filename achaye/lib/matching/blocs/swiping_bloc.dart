import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:achaye/matching/models/other_user.dart';
import 'package:achaye/matching/matching.dart';

part 'swiping_event.dart';
part 'swiping_state.dart';

class SwipingBloc extends Bloc<SwipingEvent, SwipingState> {
  MatchingRepository matchingRepository;
  SwipingBloc(this.matchingRepository) : super(SwipingInitial()) {
    on<SwipeRight>(_handleSwipeRight);
    on<GiveMeData>(_fetchData);
    on<SwipeLeft>(_handleSwipeLeft);
    on<InfoTap>(_showInformation);
    on<MoreOptionsTap>(_showOptions);
  }

  _handleSwipeRight(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      try {
        await matchingRepository.like(_state.profiles[_state.index].id);
      } catch (e) {
        emit(SwipingError());
      }

      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(_state.profiles, _state.index + 1, false)
          : NoMoreMatches());
    }
  }

  _handleSwipeLeft(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      try {
        await matchingRepository.dislike(_state.profiles[_state.index].id);
      } catch (e) {
        emit(SwipingError());
      }

      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(_state.profiles, _state.index + 1, false)
          : NoMoreMatches());
    }
  }

  _fetchData(event, emit) async {
    emit(SwipingLoading());
    List<OtherUser> suggestions = await matchingRepository.getSuggestions();

    emit(suggestions.length == 0
        ? NoMoreMatches()
        : SwipingLoaded(suggestions, 0, false));
  }

  _showInformation(event, emit) {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;
      emit(SwipingLoaded(_state.profiles, _state.index, !_state.bio));
    }
  }

  _showOptions(event, emit) {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      emit(SwipingLoaded(_state.profiles, _state.index, _state.bio));
    }
  }
}
