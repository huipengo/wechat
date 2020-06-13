import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechat/pages/chat/chat_model.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_child_page.dart';
import 'package:wechat/util/loading.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Chat> _datas = [];

  @override
  void initState() {
    super.initState();

    getDatas()
        .then((List<Chat> datas) {
          setState(() {
            _datas = datas;
          });
        })
        .catchError((onError) {
          print(onError);
        })
        .whenComplete(() {
          print('done');
        })
        .timeout(Duration(seconds: 6))
        .catchError((onError) {
          print('超时: ${onError}');
        });
  }

  Future<List<Chat>> getDatas() async {
    final response = await http
        .get('http://rap2.taobao.org:38080/app/mock/257717/api/chat/list');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<Chat> chatList = responseBody['data']
          .map<Chat>((item) => Chat.fromJson(item))
          .toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        centerTitle: true,
        title: Text('微信'),
        elevation: 0.0,
        actions: <Widget>[
          _buildPopupMenuButton(context),
        ],
      ),
      body: Container(
        child: _datas.length == 0
            ? Center(
                child: Loading(),
              )
            : _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _datas.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_datas[index].name),
          subtitle: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(right: 10),
            height: 25,
            child: Text(
              _datas[index].message,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image:
                  DecorationImage(image: NetworkImage(_datas[index].imageUr)),
              color: Colors.grey[100],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    DiscoverChildPage(title: _datas[index].name)));
          },
          onLongPress: () {},
        );
      },
    );
  }
}

Widget _buildPopupMenuButton(BuildContext context) {
  return PopupMenuButton(
    child: Container(
      margin: EdgeInsets.only(right: 10),
      child: Image(
        image: AssetImage('images/menu_round_item.png'),
        width: 25,
      ),
    ),
    tooltip: 'long press',
    itemBuilder: (BuildContext context) {
      return <PopupMenuItem<String>>[
        PopupMenuItem(
          child: _buildPopupMenuItem('images/menu_group_chat.png', '发起群聊'),
          value: 'group_chat',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('images/menu_add_friends.png', '添加朋友'),
          value: 'add_friends',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('images/menu_scan.png', '扫一扫'),
          value: 'scan',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('images/menu_receiving.png', '收付款'),
          value: 'receiving',
        ),
      ];
    },
    onSelected: (String action) {
      print(action);
    },
    onCanceled: () {
      print('canceled');
    },
    offset: Offset(0, 60.0),
  );
}

Widget _buildPopupMenuItem(String assetName, String title) {
  return Row(
    children: <Widget>[
      Image(
        image: AssetImage(assetName),
        width: 20,
      ),
      Container(
        width: 20,
      ),
      Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ],
  );
}

/*Container(
        child: FutureBuilder(
          future: getDatas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //正在加载
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading....'),
              );
            }
            //加载完毕
            return ListView(
              children: snapshot.data.map<Widget>((item) {
                return ListTile(
                    title: Text(item.name),
                    subtitle: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(right: 10),
                      height: 25,
                      child: Text(
                        item.message,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                              image: NetworkImage(item.imageUrl))),
                    ));
              }).toList(),
            );
          },
        ),
      ),
* */
