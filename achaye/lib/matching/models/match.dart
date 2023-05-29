import 'package:equatable/equatable.dart';

class Match extends Equatable {
  String chatId;
  String partnerId;
  int unreadCount;
  String appointment;

  Match({
    required this.chatId,
    required this.partnerId,
    required this.unreadCount,
    required this.appointment,
  });

  Match.fromJson(json)
      : chatId = json["chatId"] as String,
        partnerId = json["partnerId"] as String,
        unreadCount = json["unreadCount"] as int,
        appointment = json["appointment"] as String;

  Map<String, Object> toJson() {
    Map<String, Object> json = {
      "chatId": chatId,
      "partnerId": partnerId,
      "unreadCount": unreadCount,
      "appointment": appointment
    };

    return json;
  }

  @override
  List<Object?> get props => [
        chatId,
        partnerId,
        unreadCount,
        appointment,
      ];
}
