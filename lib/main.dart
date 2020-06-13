import 'package:flutter/material.dart';
import 'package:wechat/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeChat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
        splashColor: Color.fromRGBO(1, 0, 0, 0.0),
        cardColor: Color.fromRGBO(1, 1, 1, 0.65),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(),
    );
  }
}
