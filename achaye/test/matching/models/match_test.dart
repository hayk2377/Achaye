import 'package:achaye/matching/models/match.dart';
import 'package:test/test.dart';

void main() {
  var matchWithAppointment = Match(
    chatId: "abc",
    partnerId: "abcd",
    unreadCount: 5,
    appointment: "8/8/20",
  );

  test("chatId should be the same", () {
    expect(matchWithAppointment.chatId, "abc");
  });

  test("should have appoinment if not null", () {
    var match = Match.fromMap(<String, dynamic>{
      "chatId": "abc",
      "partnerId": "abcs",
      "unreadCount": 5,
      "appointment": "app date"
    });

    expect(match.appointment, "app date");
  });
}
