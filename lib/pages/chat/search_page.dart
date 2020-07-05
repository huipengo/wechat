import 'package:flutter/material.dart';
import 'chat_model.dart';
import 'search_bar.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;

  const SearchPage({Key key, this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _results = [];
  String _searchText = '';

  void _searchData(String text) {
    _results.clear();
    _searchText = text;
    if (text.length > 0) {
      for (int i = 0; i < widget.datas.length; i++) {
        String name = widget.datas[i].name;
        if (name.contains(text)) {
          _results.add(widget.datas[i]);
        }
      }
    }
    setState(() {});
  }

  TextStyle _normalStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  TextStyle _highlightedStyle = TextStyle(
    fontSize: 16,
    color: Colors.green,
  );

  Widget _richText(String name) {
    List<TextSpan> spans = [];
    List<String> list = name.split(_searchText);
    for (int i = 0; i < list.length; i++) {
      String str = list[i];
      if (str == '' && i < list.length - 1) {
        spans.add(TextSpan(text: _searchText, style: _highlightedStyle));
      } else {
        spans.add(TextSpan(text: str, style: _normalStyle));
        if (i < list.length - 1) {
          spans.add(TextSpan(text: _searchText, style: _highlightedStyle));
        }
      }
    }
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChanged: (String text) {
              _searchData(text);
            },
          ),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NotificationListener(
                onNotification: (note) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  return true;
                },
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: _buildCellForRow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    return ListTile(
        title: _richText(_results[index].name),
        subtitle: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(right: 10),
          height: 25,
          child: Text(
            _results[index].message,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                  image: NetworkImage(_results[index].imageUrl))),
        ));
  }
}
