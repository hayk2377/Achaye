part of 'chat_list_bloc.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListError extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ProfileLog> data;

  const ChatListLoaded(this.data);
  @override
  List<Object> get props => data;
}

class ReOrderMessages extends ChatListState {
  final List<ProfileLog> data;

  ReOrderMessages(this.data);
  @override
  List<Object> get props {
    List<Object> parentProps = super.props;
    parentProps += this.data;
    return parentProps;
  }
}

class NoMessages extends ChatListState {}
