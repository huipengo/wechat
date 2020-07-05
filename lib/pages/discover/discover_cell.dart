import 'package:flutter/material.dart';
import 'discover_child_page.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String content;
  final String image;
  final String point;

  DiscoverCell(
      {Key key,
      @required this.title,
      this.content,
      @required this.image,
      this.point})
      : assert(title != null, 'title 不能为空'),
        assert(image != null, 'image 不能为空'),
        super(key: key);

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
                  title: widget.title,
                )));
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
      child: Container(
        padding: EdgeInsets.all(10),
        color: _currentColor,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.image),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.title),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    widget.content ?? '',
                    style: TextStyle(color: Colors.grey),
                  ),
                  widget.point != null
                      ? Container(
                          child: Image(
                            image: AssetImage(widget.point),
                            width: 15,
                          ),
                          margin: EdgeInsets.only(left: 3, right: 3),
                        )
                      : Container(),
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
    );
  }
}
