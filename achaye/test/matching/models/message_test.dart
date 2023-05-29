import 'package:achaye/matching/models/message.dart';
import 'package:test/test.dart';

void main() {
  var message = Message(content: "abc", sentBySelf: true);
  test("content should be the same", () {
    expect(message.content, "abc");
  });

  test("toJson should have content", () {
    var json = message.toJson();
    expect(message.content, json["content"]);
  });

  test("toJson() fromJson() should equal original message", () {
    var json = message.toJson();
    var sameMessage = Message.fromJson(json);
    expect(message, sameMessage);
  });
}
