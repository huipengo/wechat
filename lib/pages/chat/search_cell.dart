import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';
import 'chat_model.dart';
import 'search_page.dart';

class SearchCell extends StatelessWidget {
  final List<Chat> datas;

  const SearchCell({this.datas});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext conext) => SearchPage(
              datas: datas,
            )));
      },
      child: Container(
        height: 44,
        color: WeChatThemeColor,
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('images/loupe.png'),
                  width: 15,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '搜索',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
