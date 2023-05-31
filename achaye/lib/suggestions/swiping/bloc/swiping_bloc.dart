import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/profile.dart';

part 'swiping_event.dart';
part 'swiping_state.dart';

class SwipingBloc extends Bloc<SwipingEvent, SwipingState> {
  SwipingBloc() : super(SwipingInitial()) {
    on<SwipeRight>(_handleSwipeRight);
    on<GiveMeData>(_fetchData);
    on<SwipeLeft>(_handleSwipeLeft);
    on<InfoTap>(_showInformation);
    on<MoreOptionsTap>(_showOptions);
  }

  _handleSwipeRight(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(
              _state.profiles, _state.index + 1, false, _state.options)
          : NoMoreMatches());
    }
  }

  _handleSwipeLeft(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;
      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(
              _state.profiles, _state.index + 1, false, _state.options)
          : NoMoreMatches());
    }
  }

  _fetchData(event, emit) async {
    emit(SwipingLoading());
    await Future.delayed(const Duration(seconds: 2));
    List<Profile> data = [
      Profile(
          name: "Ruth",
          distance: "2km",
          image: "images/girlfive.jpg",
          id: 1,
          bio:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      Profile(
          name: "Helen",
          distance: "3km",
          image: "images/girltwo.jpg",
          id: 2,
          bio: "Nothing to see here move along"),
      Profile(
          name: "Alice",
          distance: "10km",
          image: "images/girlnine.jpg",
          id: 3,
          bio: "Hey Nice to meet you"),
      Profile(
          name: "Betty",
          distance: "6km",
          image: "images/girlfour.jpg",
          id: 4,
          bio: "I know for a fact I am very pretty"),
    ];
    emit(data.length == 0
        ? NoMoreMatches()
        : SwipingLoaded(data, 0, false, false));
  }

  _showInformation(event, emit) {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;
      emit(SwipingLoaded(
          _state.profiles, _state.index, !_state.bio, _state.options));
    }
  }

  _showOptions(event, emit) {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      emit(SwipingLoaded(
          _state.profiles, _state.index, _state.bio, !_state.bio));
    }
  }
}
