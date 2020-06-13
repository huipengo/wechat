import 'package:flutter/material.dart';
import '../const.dart';

class DiscoverChildPage extends StatefulWidget {

  final String title;

  const DiscoverChildPage({Key key, this.title}) : super(key: key);

  @override
  _DiscoverChildPageState createState() => _DiscoverChildPageState();
}

class _DiscoverChildPageState extends State<DiscoverChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
