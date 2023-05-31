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
  final bool bio;
  final bool options;

  const SwipingLoaded(this.profiles, this.index, this.bio, this.options);

  @override
  List<Object?> get props => [profiles, index, bio];
}

class NoMoreMatches extends SwipingState {}

enum BioRender { None, Render }
