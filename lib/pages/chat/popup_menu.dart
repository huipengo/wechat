import 'package:flutter/material.dart';

Widget popupMenuButton(BuildContext context) {
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
