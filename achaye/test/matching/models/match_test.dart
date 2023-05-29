import 'package:achaye/matching/models/match.dart';
import 'package:test/test.dart';

void main() {
  var match = Match(
    chatId: "abc",
    partnerId: "abcd",
    unreadCount: 5,
    appointment: "8/8/20",
  );

  test("chatId should be the same", () {
    expect(match.chatId, "abc");
  });

  test("toJson should have chatId", () {
    var json = match.toJson();
    expect(match.chatId, json["chatId"]);
  });

  test("toJson() fromJson() should equal original match", () {
    var json = match.toJson();
    var sameMatch = Match.fromJson(json);
    expect(match, sameMatch);
  });
}
