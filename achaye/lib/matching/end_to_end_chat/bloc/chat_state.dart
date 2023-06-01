part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final TextEditingController writtenMessage;
  final ScrollController scrollController;

  ChatLoaded({required this.messages, required this.writtenMessage, required this.scrollController});

  @override
  List<Object> get props => [messages, writtenMessage, scrollController];
}

class ChatError extends ChatState {}
