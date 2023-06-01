import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/profilelog.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatEvent, ChatState> {
  ChatListBloc() : super(ChatListInitial()) {
    on<FetchData>(_fetchData);
    on<NewTextArrival>(_reorderChats);
  }

  _fetchData(event, emit) async {
    emit(ChatListLoading());

    await Future.delayed(Duration(seconds: 2));

    List<ProfileLog> chatActivity = [
      ProfileLog(
          name: "Anna",
          id: 1,
          image: 'images/girltwo.jpg',
          recentTyped: 'Heyyy you',
          time: DateTime.parse('2023-05-24 09:32:00')),
      ProfileLog(
          name: "Pam",
          id: 3,
          image: 'images/girlfour.jpg',
          recentTyped: 'Your my Jim?? 😂😂',
          time: DateTime.parse('2023-05-26 09:32:00')),
      ProfileLog(
          name: "Helena",
          id: 2,
          image: 'images/girleight.jpg',
          recentTyped: 'What did I hear 👀',
          time: DateTime.parse('2022-05-01 14:30:00')),
      ProfileLog(
          name: "Angela",
          id: 4,
          image: 'images/girlseven.jpg',
          recentTyped: 'Goodnight😘',
          time: DateTime.parse('2021-02-01 14:00:00')),
    ];
    chatActivity.sort((a, b) => a.time!.millisecondsSinceEpoch
        .compareTo(b.time!.millisecondsSinceEpoch));

    emit(ChatListLoaded(chatActivity.reversed.toList()));
  }

  _reorderChats(event, emit) async {
    if (state is ChatListLoaded) {
      final _state = state as ChatListLoaded;

      List<ProfileLog> duplicateList = List.of(_state.data);
      duplicateList.add(
        ProfileLog(
            name: "Helena's sister",
            id: 10,
            image: 'images/girlnine.jpg',
            recentTyped: 'What did I hear 👀',
            time: DateTime.now()),
      );
      duplicateList.sort((a, b) => a.time!.millisecondsSinceEpoch
          .compareTo(b.time!.millisecondsSinceEpoch));
      emit(ChatListLoaded(duplicateList.reversed.toList()));

    }
  }
}

