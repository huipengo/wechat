class Chat {
  final String imageUrl;
  final String name;
  final String message;

  const Chat({this.imageUrl, this.name, this.message});
  factory Chat.fromJson(Map json) {
    return Chat(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      message: json['message'] as String,
    );
  }
}
