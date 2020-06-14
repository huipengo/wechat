import 'package:flutter/material.dart';
import 'package:wechat/pages/chat/chat_model.dart';
import 'package:wechat/pages/chat/popup_menu.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_child_page.dart';
import 'package:wechat/util/loading.dart';

import 'chat_helper.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {
  List<Chat> _datas = [];

  @override
  void initState() {
    super.initState();

    getChatDatas().then((List<Chat> datas) {
      setState(() {
        _datas = datas;
      });
    }).catchError((onError) {
      _datas = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        centerTitle: true,
        title: Text('微信'),
        elevation: 0.0,
        actions: <Widget>[
          popupMenuButton(context),
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
        return _buildCellForRow(context, index);
      },
    );
  }

  ListTile _buildCellForRow(BuildContext context, int index) {
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
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
