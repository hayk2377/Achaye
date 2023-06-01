part of 'chat_list_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatState {}

class ChatListLoading extends ChatState {}

class ChatListError extends ChatState {}

class ChatListLoaded extends ChatState {
  final List<ProfileLog> data;

  const ChatListLoaded(this.data);
  @override
  List<Object> get props => data;
}

class ReOrderMessages extends ChatState {
  final List<ProfileLog> data;

  ReOrderMessages(this.data);
  @override
  List<Object> get props {
    List<Object> parentProps = super.props;
    parentProps += this.data;
    return parentProps;
  }
}

class NoMessages extends ChatState {}
