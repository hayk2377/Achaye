part of 'chat_list_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends ChatEvent{}

class NewTextArrival extends ChatEvent{}
