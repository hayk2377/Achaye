part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GiveMeChatData extends ChatEvent {}

class TextArrival extends ChatEvent {}

class TextSent extends ChatEvent {}
