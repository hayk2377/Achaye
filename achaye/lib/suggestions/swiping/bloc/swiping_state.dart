part of 'swiping_bloc.dart';

abstract class SwipingState extends Equatable {
  const SwipingState();

  @override
  List<Object?> get props => [];
}

class SwipingInitial extends SwipingState {}

class SwipingLoading extends SwipingState {}

class SwipingError extends SwipingState {}

class SwipingLoaded extends SwipingState {
  final List<Profile> profiles;
  final int index;

  const SwipingLoaded(this.profiles, this.index);

  @override
  List<Object?> get props => [profiles, index];
}

class NoMoreMatches extends SwipingState{}
