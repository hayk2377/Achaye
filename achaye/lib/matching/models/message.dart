import 'package:equatable/equatable.dart';

class Message extends Equatable {
  String content;
  bool sentBySelf;
  DateTime time = DateTime.now();

  Message({required this.content, required this.sentBySelf});
  Message.fromJson(Map<String, Object> json)
      : content = json["content"] as String,
        sentBySelf = json["sentBySelf"] as bool;

  Map<String, Object> toJson() {
    Map<String, Object> json = {
      "content": content,
      "sentBySelf": sentBySelf,
      "time": time
    };
    return json;
  }

  @override
  List<Object?> get props => [content, sentBySelf];
}
