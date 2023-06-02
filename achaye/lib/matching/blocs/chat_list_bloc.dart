import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/profilelog.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListInitial()) {
    on<FetchData>(_fetchData);
    on<NewTextArrival>(_reorderChats);
  }

  _fetchData(event, emit) async {
    emit(ChatListLoading());

    await Future.delayed(Duration(seconds: 2));

    List<ProfileLog> chatActivity = [];

    chatActivity.sort((a, b) => a.time!.millisecondsSinceEpoch
        .compareTo(b.time!.millisecondsSinceEpoch));

    emit(ChatListLoaded(chatActivity.reversed.toList()));
  }

  _reorderChats(event, emit) async {
    if (state is ChatListLoaded) {
      final _state = state as ChatListLoaded;
    }
  }
}
