import 'package:flutter/material.dart';

// 主图色
final Color WeChatThemeColor = Color.fromRGBO(223, 223, 223, 1.0);

// 屏幕的宽高
double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

Widget SeparatorStyleSingleLine() {
  return Row(
    children: <Widget>[
      Container(
        width: 50,
        height: 0.5,
        color: Colors.white,
      ),
      Container(height: 0.5, color: Colors.grey)
    ],
  );
}
