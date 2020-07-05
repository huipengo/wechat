import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_child_page.dart';
import 'package:wechat/pages/friends/friends_cell.dart';
import 'package:wechat/pages/friends/friends_model.dart';
import 'package:wechat/pages/friends/index_bar.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin {
  // 字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {INDEX_WORDS[0]: 0.0, INDEX_WORDS[1]: 0.0};

  ScrollController _scrollController;

  final List<Friends> _listDatas = [];

  @override
  void initState() {
    super.initState();

    _listDatas..addAll(datas);
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    _scrollController = ScrollController();

    var _groupOffset = 54.5 * 4;
    //经过循环计算,将每一个头的位置算出来,放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1) {
        //第一个Cell是有头部的
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加_groupOffset
        _groupOffset += 84.5;
      } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //此时没有头部,只需要加偏移量就行了!
        _groupOffset += 54.5;
      } else {
        //这部分就是有头部的了
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84.5;
      }
    }
  }

  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/icon_new_friend.png', name: '新的朋友'),
    Friends(imageUrl: 'images/icon_group_chat.png', name: '群聊'),
    Friends(imageUrl: 'images/icon_label.png', name: '标签'),
    Friends(imageUrl: 'images/icon_public.png', name: '公众号'),
  ];

  Widget _itemForRow(BuildContext context, int index) {
    if (index < _headerData.length) {
      return FriendsCell(
        name: _headerData[index].name,
        imageAssets: _headerData[index].imageUrl,
      );
    }

    int _index = index - 4;
    bool _hiddenIndexLetter = (_index > 0 &&
        _listDatas[_index].indexLetter == _listDatas[_index - 1].indexLetter);
    return FriendsCell(
      imageUrl: _listDatas[_index].imageUrl,
      name: _listDatas[_index].name,
      groupTitle: _hiddenIndexLetter ? null : _listDatas[_index].indexLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        centerTitle: true,
        title: Text('通讯录'),
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverChildPage(
                        title: '添加朋友',
                      )));
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: _itemForRow,
              itemCount: _headerData.length + _listDatas.length,
            ),
          ),
          IndexBar(
            indexBarCallBack: (String str) {
              print(_groupOffsetMap[str]);
              //保证安全,是在我的字典里面的字符
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(
                  _groupOffsetMap[str] as double, //字典中有每个字符的滚动距离,直接拿出来!
                  duration: Duration(microseconds: 100), curve: Curves.easeIn,
                );
              }
            },
          ), //悬浮控件
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
