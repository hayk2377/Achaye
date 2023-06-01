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
  final List<OtherUser> profiles;
  final int index;
  final bool bio;

  const SwipingLoaded(this.profiles, this.index, this.bio);

  @override
  List<Object?> get props => [profiles, index, bio];
}

class NoMoreMatches extends SwipingState {}

enum BioRender { None, Render }
