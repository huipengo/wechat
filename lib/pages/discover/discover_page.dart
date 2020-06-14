import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin {
  Color _themeColor = WeChatThemeColor;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeColor,
        centerTitle: true,
        title: Text('发现'),
        elevation: 0.0,
      ),
      body: Container(
        color: _themeColor,
        height: 800,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              title: '朋友圈',
              image: 'images/friends.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '扫一扫',
              image: 'images/rich_scan.png',
            ),
            SeparatorStyleSingleLine(),
            DiscoverCell(
              image: 'images/shark.png',
              title: '摇一摇',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              image: 'images/take_a_look.png',
              title: '看一看',
            ),
            SeparatorStyleSingleLine(),
            DiscoverCell(
              image: 'images/search.png',
              title: '搜一搜',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              image: 'images/people_nearby.png',
              title: '附近的人',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              image: 'images/shopping.png',
              title: '购物',
              content: '618 限时特价',
              point: 'images/badge.png',
            ),
            SeparatorStyleSingleLine(),
            DiscoverCell(
              image: 'images/game.png',
              title: '游戏',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              image: 'images/mini_program.png',
              title: '小程序',
            ),
          ],
        ),
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
