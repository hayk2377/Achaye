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
    on<NoMoreData>(_notifyNoData);
  }

  _handleSwipeRight(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;

      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(_state.profiles, _state.index + 1)
          : NoMoreMatches());
    }
  }

  _handleSwipeLeft(event, emit) async {
    if (state is SwipingLoaded) {
      final _state = state as SwipingLoaded;
      emit(_state.index < _state.profiles.length - 1
          ? SwipingLoaded(_state.profiles, _state.index + 1)
          : NoMoreMatches());
    }
  }

  _fetchData(event, emit) async {
    emit(SwipingLoading());
    await Future.delayed(const Duration(seconds: 2));
    List<Profile> data = [
      Profile(
          name: "Ruth", distance: "2km", image: "images/girlfive.jpg", id: 1),
      Profile(
          name: "Helen", distance: "3km", image: "images/girltwo.jpg", id: 2),
      Profile(
          name: "Alice", distance: "10km", image: "images/girlnine.jpg", id: 3),
      Profile(
          name: "Betty", distance: "6km", image: "images/girlfour.jpg", id: 4),
    ];
    emit(data.length == 0 ? NoMoreMatches() : SwipingLoaded(data, 0));
  }

  _notifyNoData(event, emit) async {
    emit(NoMoreMatches());
  }
}

// EVENTS ARE REQUESTS