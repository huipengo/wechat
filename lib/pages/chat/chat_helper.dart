import 'package:wechat/network/http.dart' as http;
import 'chat_model.dart';

Future<List<Chat>> getChatDatas() async {
  final response = await http
      .get('http://rap2.taobao.org:38080/app/mock/257717/api/chat/list');
  if (response.statusCode == http.Code.SUCCESS) {
    List<Chat> chatList = response.data
        .map<Chat>((item) => Chat.fromJson(item as Map<dynamic, dynamic>))
        .toList() as List<Chat>;
    return chatList;
  } else {
    throw Exception('${response.statusCode}');
  }
}
