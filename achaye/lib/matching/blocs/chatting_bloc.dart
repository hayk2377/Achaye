import 'package:achaye/matching/matching.dart';
import 'package:achaye/matching/models/other_user.dart';
import 'package:achaye/matching/repository/matching_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:achaye/matching/models/message.dart';
import 'package:achaye/matching/models/match.dart';
import 'package:bloc/bloc.dart';

import '../models/profilelog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  MatchingRepository matchingRepository;
  ChattingBloc(this.matchingRepository) : super(ChattingInitial()) {
    on<FetchData>(_fetchData);
    on<TextArrival>(_handleArrival);
    on<TextSent>(_sendText);
  }

  _sendText(event, emit) {
    if (state is ChatsLoaded) {
      String content = (event as TextSent).content;
      String chatId = (event as TextSent).content;
      WebSocketChannel? channel = (state as ChatsLoaded).channels[chatId];
      channel!.sink.add(content);
    }
  }

  Future<ChatsLoaded> _initializeChats() async {
    List<Match> eachMatch = await matchingRepository.getMatches();
    List<List<Message>> eachMessages = [];
    Map<String, OtherUser> partners = {};
    Map<String, WebSocketChannel> channels = {};

    for (Match match in eachMatch) {
      String chatId = match.chatId;
      List<Message> messages = await matchingRepository.getMessages(chatId);
      eachMessages.add(messages);

      var channel = matchingRepository.enterChat(chatId: chatId);
      channels[chatId] = channel;
      channel.stream.listen((content) {
        var incomingContent = content as String;
        add(TextArrival(content: incomingContent, chatId: chatId));
      });

      String partnerId = match.partnerId;
      OtherUser partner = await matchingRepository.getOtherUser(partnerId);
      partners[partnerId] = partner;
    }
    var state = ChatsLoaded(
        eachMatch: eachMatch,
        eachMessages: eachMessages,
        partners: partners,
        channels: channels);
    return state;
  }

  _fetchData(event, emit) async {
    if (state is ChattingInitial) {
      emit(ChattingLoading());
      ChatsLoaded loadedState = await _initializeChats();
      emit(loadedState);
    } else if (state is ChatsLoaded) {
      emit(ChattingLoading());
      (state as ChatsLoaded).closeChannels();
      ChatsLoaded loadedState = await _initializeChats();
      emit(loadedState);
    }
  }

  _handleArrival(event, emit) async {
    if (state is ChatsLoaded) {
      ChatsLoaded newState = (state as ChatsLoaded).copy();
      String chatId = (event as TextArrival).chatId;
      String content = (event as TextArrival).content;

      (newState.messages[chatId] as List<Message>)
          .add(Message(content: content, sentBySelf: false));

      emit(newState);
    }
  }
}
