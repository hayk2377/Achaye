class Message {
  String content;
  bool sentBySelf;

  Message(this.content, this.sentBySelf);
  Message.fromJson(Map<String, Object> json)
      : content = json["content"] as String,
        sentBySelf = json["sentBySelf"] as bool;

  Map<String, Object> toJson() {
    Map<String, Object> json = {"content": content, "sentBySelf": sentBySelf};
    return json;
  }
}
