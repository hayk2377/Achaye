part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends ChatListEvent {}

class NewTextArrival extends ChatListEvent {}
