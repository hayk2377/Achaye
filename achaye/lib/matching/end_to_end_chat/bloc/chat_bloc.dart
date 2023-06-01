import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GiveMeData>(_fetchData);
    on<TextSent>(_sendMessage);
    on<TextArrival>(_recieveMessage);
  }

  _fetchData(event, emit) async {
    emit(ChatLoading());

    await Future.delayed(Duration(seconds: 2));
    List<Message> messages = [
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Ere Alehu", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(
          content:
              "Tefah eko bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
          sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
      Message(content: "Tefah eko", sentBySelf: true),
      Message(content: "Tefah eko", sentBySelf: false),
    ];

    emit(ChatLoaded(
        messages: messages, writtenMessage: TextEditingController(), scrollController: ScrollController()));
  }

  _sendMessage(event, emit) {
    if (state is ChatLoaded) {
      final _state = state as ChatLoaded;
      List<Message> newMessages = List.of(_state.messages);
      newMessages
          .add(Message(content: _state.writtenMessage.text, sentBySelf: true));
      _state.scrollController.animateTo(
          _state.scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut);
      emit(
        ChatLoaded(
            messages: newMessages,
            writtenMessage: TextEditingController(),
            scrollController: _state.scrollController),
      );
    }
  }

  _recieveMessage(event, emit) {
    if (state is ChatLoaded) {
      final _state = state as ChatLoaded;
      List<Message> newMessages = List.of(_state.messages);
      newMessages.add(Message(content: "You don'\t say 😏", sentBySelf: false));

      emit(ChatLoaded(
          messages: newMessages, writtenMessage: _state.writtenMessage, scrollController: _state.scrollController));
    }
  }
}
