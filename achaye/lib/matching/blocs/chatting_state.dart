part of 'chatting_bloc.dart';

abstract class ChattingState extends Equatable {
  const ChattingState();

  @override
  List<Object> get props => [];
}

class ChatsLoaded extends ChattingState {
  late Map<String, OtherUser> partners;
  late Map<String, List<Message>> messages;
  late Map<String, Match> matches;
  late Map<String, WebSocketChannel> channels;
  late List<ProfileLog> profileLogs;
  final TextEditingController writtenMessage;
  String? currentChat;

  ChatsLoaded(
      {
      //
      required List<Match> listMatches,
      required List<List<Message>> messagesList,
      required this.partners,
      required this.channels,
      this.currentChat,
      required this.writtenMessage
      //
      }) {
    for (int i = 0; i < listMatches.length; i++) {
      Match thisMatch = listMatches[i];
      List<Message> thisMessages = messagesList[i];
      OtherUser partner = partners[thisMatch.partnerId] as OtherUser;

      String chatId = thisMatch.chatId;
      matches[chatId] = thisMatch;
      messages[chatId] = thisMessages;

      var profileLog = ProfileLog(
          recentTyped: thisMessages.last.content,
          time: thisMessages.last.time,
          name: partner.firstName,
          id: chatId,
          image: partner.photoUrl);

      profileLogs.add(profileLog);
    }
    _orderProfileLogs();
  }

  _orderProfileLogs() {
    profileLogs.sort((a, b) => a.time!.millisecondsSinceEpoch
        .compareTo(b.time!.millisecondsSinceEpoch));
  }

  closeChannels() {
    for (String chatId in channels.keys) {
      (channels[chatId] as WebSocketChannel).sink.close();
    }
  }

  ChatsLoaded copy() {
    List<Match> listMatches = [];
    List<List<Message>> messagesList = [];
    Map<String, OtherUser> copyPartners = Map.from(partners);

    for (String key in matches.keys) {
      Match match = matches[key] as Match;
      listMatches.add(match);

      List<Message> matchMessages = [];
      for (Message message in (messages[key] as List<Message>)) {
        matchMessages.add(message);
      }
      messagesList.add(matchMessages);
    }

    return ChatsLoaded(
      writtenMessage: TextEditingController(),
        listMatches: listMatches,
        messagesList: messagesList,
        partners: copyPartners,
        channels: channels);
  }

  @override
  List<Object> get props => [...profileLogs];
}

class ChattingInitial extends ChattingState {}

class ChattingLoading extends ChattingState {}

class ChattingError extends ChattingState {}

class NoMessages extends ChattingState {}
