import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';
import 'package:wechat/pages/discover/discover_child_page.dart';

class FriendsCell extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const FriendsCell(
      {this.imageUrl, this.name, this.groupTitle, this.imageAssets});

  @override
  State<StatefulWidget> createState() => _FriendsCellState();
}

class _FriendsCellState extends State<FriendsCell> {

  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                DiscoverChildPage(title: widget.name)));
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey[100];
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            height: widget.groupTitle != null ? 30 : 0,
            color: WeChatThemeColor,
            child: widget.groupTitle != null ? Text(widget.groupTitle, style: TextStyle(color: Colors.grey),) : null,
          ),
          Container(
            color: _currentColor,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: widget.imageUrl != null ? NetworkImage(widget.imageUrl) : AssetImage(widget.imageAssets),
                      ),
                      color: Colors.grey[100]
                  ),
                ),
                Container(
                  child: Text(widget.name, style: TextStyle(fontSize: 15),),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: WeChatThemeColor,
            child: SeparatorStyleSingleLine(),
          ),
        ],
      ),
    );
  }
}
