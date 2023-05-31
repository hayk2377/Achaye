import 'package:achaye/matching/models/message.dart';
import 'package:test/test.dart';

void main() {
  var message = Message(content: "abc", sentBySelf: true);
  test("content should be the same", () {
    expect(message.content, "abc");
  });

  test("toMap should have content", () {
    var json = message.toMap();
    expect(message.content, json["content"]);
  });

  test("toMap() fromMap() should equal original message", () {
    var json = message.toMap();
    var sameMessage = Message.fromMap(json);
    expect(message, sameMessage);
  });
}
