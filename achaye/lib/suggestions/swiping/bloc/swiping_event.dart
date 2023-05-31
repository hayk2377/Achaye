part of 'swiping_bloc.dart';

abstract class SwipingEvent extends Equatable {
  const SwipingEvent();

  @override
  List<Object> get props => [];
}

class GiveMeData extends SwipingEvent {}

class SwipeRight extends SwipingEvent {}

class SwipeLeft extends SwipingEvent {}

class InfoTap extends SwipingEvent {}

class MoreOptionsTap extends SwipingEvent{}