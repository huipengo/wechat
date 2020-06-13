class Chat {
  final String imageUr;
  final String name;
  final String message;

  const Chat({this.imageUr, this.name, this.message});
  factory Chat.fromJson(Map json) {
    return Chat(
      imageUr: json['imageUrl'],
      name: json['name'],
      message: json['message'],
    );
  }
}