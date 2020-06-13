import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_cell.dart';

import 'discover/discover_child_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    _headerWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      image: 'images/wechat_pay.png',
                      title: '支付',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      image: 'images/wechat_collection.png',
                      title: '收藏',
                    ),
                    SeparatorStyleSingleLine(),
                    DiscoverCell(
                      image: 'images/wechat_album.png',
                      title: '相册',
                    ),
                    SeparatorStyleSingleLine(),
                    DiscoverCell(
                      image: 'images/wechat_card_package.png',
                      title: '卡包',
                    ),
                    SeparatorStyleSingleLine(),
                    DiscoverCell(
                        image: 'images/wechat_expression.png', title: '表情'),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      image: 'images/wechat_set.png',
                      title: '设置',
                    ),
                  ],
                )),
          ),
          _cameraWidget(context),
        ],
      ),
    );
  }
}

Widget _headerWidget() {
  return Container(
    color: Colors.white,
    height: 200,
    child: Container(
      margin: EdgeInsets.only(top: 100, bottom: 20),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('images/icon_lufei.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 8, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 35,
                      child: Text(
                        '路飞',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '继承🔥之意志，成为海贼王的男人！',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          Image(
                            image: AssetImage('images/icon_right.png'),
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _cameraWidget(BuildContext context) {
  return GestureDetector(
    child: Container(
      height: 25,
      color: Color.fromRGBO(0, 0, 0, 0),
      margin: EdgeInsets.only(top: 50, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image(
            image: AssetImage('images/camera.png'),
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => DiscoverChildPage(
            title: '拍视频',
          ),
        ),
      );
    },
  );
}
