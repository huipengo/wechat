import 'package:flutter/material.dart';
import 'package:wechat/pages/const.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  _onChanged(String text) {
    widget.onChanged(text);
    setState(() {
      _showClear = (text.length > 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = getStatusBarHeight(context);
    double navigationBarHeight = 44.0;
    return Container(
      height: (statusBarHeight + navigationBarHeight),
      color: WeChatThemeColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: statusBarHeight,
          ),
          Container(
            height: navigationBarHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenWidth(context) - 50,
                  height: 34,
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/loupe.png'),
                        width: 20,
                        color: Colors.grey,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _controller,
                          onChanged: _onChanged,
                          autofocus: true,
                          cursorColor: Colors.green,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 5, bottom: 12),
                            border: InputBorder.none,
                            hintText: '搜索',
                          ),
                        ),
                      ),
                      _showClear ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.clear();
                            _onChanged('');
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('  取消'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double getStatusBarHeight(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  return mediaQuery.padding.top;
}
