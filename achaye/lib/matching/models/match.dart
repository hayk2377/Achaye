import 'package:equatable/equatable.dart';

class Match extends Equatable {
  String chatId;
  String partnerId;
  int unreadCount;
  String? appointment;

  Match({
    required this.chatId,
    required this.partnerId,
    required this.unreadCount,
    required this.appointment,
  });

  Match.fromMap(Map<String, dynamic> json)
      : chatId = json["chatId"] as String,
        partnerId = json["partnerId"] as String,
        unreadCount = json["unreadCount"] as int,
        appointment = json["appointment"];

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> map = {
  //     "chatId": chatId,
  //     "partnerId": partnerId,
  //     "unreadCount": unreadCount,
  //     "appointment": appointment
  //   };

  // return map;
  // }

  @override
  List<Object?> get props => [
        chatId,
        partnerId,
        unreadCount,
        appointment,
      ];
}
