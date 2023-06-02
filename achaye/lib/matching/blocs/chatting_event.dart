part of 'chatting_bloc.dart';

abstract class ChattingEvent extends Equatable {
  const ChattingEvent();

  @override
  List<Object> get props => [];
}

class TextArrival extends ChattingEvent {
  String content;
  String chatId;

  TextArrival({required this.content, required this.chatId});
}

class TextSent extends ChattingEvent {
  final String content;

  final String chatId;
  TextSent({required this.content, required this.chatId});
}

class GiveMeChatData extends ChattingEvent {}

class FetchData extends ChattingEvent {}
