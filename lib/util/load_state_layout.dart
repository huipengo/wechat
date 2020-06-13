import 'package:flutter/material.dart';

///四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

///根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {

  final LoadState state; //页面状态
  final Widget successWidget;//成功视图
  final VoidCallback errorRetry; //错误事件处理

  LoadStateLayout(
      {Key key,
        this.state = LoadState.State_Loading,//默认为加载状态
        this.successWidget,
        this.errorRetry})
      : super(key: key);

  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.successWidget;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return _loadingView;
        break;
      case LoadState.State_Empty:
        return _emptyView;
        break;
      default:
        return null;
    }
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.transparent),
      alignment: Alignment.center,
      child: Container(
        width: 85.0,
        height: 85.0,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xFF939393), borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 5.0),
            Text('正在加载', style: TextStyle(color: const Color(0xFF212121), fontSize: 14.0),)
          ],
        ),
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/placeholder.png',
            height: 120,
            width: 169,
          ),
          SizedBox(height: 12.0),
          Text("加载失败，请重试", style: TextStyle(fontSize: 14.0, color: const Color(0xFF212121))),
          SizedBox(height: 5.0),
          RaisedButton(
            onPressed: widget.errorRetry,
            child: Text('重新加载'),
            textColor: Colors.white,
            color: Color(0xFF4C5CF3),
            highlightColor: Color(0xFF3333FF),
          )
        ],
      ),
    );
  }

  ///数据为空的视图
  Widget get _emptyView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/placeholder.png',
            height: 120,
            width: 169,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text("暂无数据", style: TextStyle(fontSize: 16.0, color: const Color(0xFF212121))),
          )
        ],
      ),
    );
  }
}