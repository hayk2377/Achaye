part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ProfileLog> data;

  const ChatLoaded(this.data);
  @override
  List<Object> get props => data;
}

class ReOrderMessages extends ChatState {
  List<ProfileLog> data;

  ReOrderMessages(this.data);
  @override
  List<Object> get props {
    List<Object> parentProps = super.props;
    parentProps += this.data;
    return parentProps;
  }
}

class NoMessages extends ChatState {}
