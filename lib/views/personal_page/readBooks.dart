import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/commentbook.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:redux/redux.dart';
import 'package:intl/intl.dart';
import 'package:wm_library/components/comment/tips_dialog.dart';
import 'package:wm_library/redux/app_reducer.dart';

///在读书籍
class ReadBooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReadBooksState();
  }
}

class _ReadBooksState extends State<ReadBooks> {
  TextEditingController _commentController = new TextEditingController();
  bool tag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    BorrowBookActionCreator.getBorrowBook(_getStore());
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      int size = _getStore().state.borrowBook == null
          ? 0 : _getStore().state.borrowBook.data == null
          ? 0 : _getStore().state.borrowBook.data.length;
      if (size == 0) {
        return getCenter();
      }

      return new ListView.builder(
          itemCount: _getStore().state.borrowBook == null
              ? 0 : _getStore().state.borrowBook.data == null
              ? 0 : _getStore().state.borrowBook.data.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          });
    }, onDidChange: (store) {
      _onDidChange(store);
    });
  }

  Widget getCenter() {
    return new Center(
      child: new Text(
        '暂无数据',
        style: TextStyle(color: Colors.black, fontSize: screen.setSp(20)),
      ),
    );
  }

  Widget getRow(int position) {
    //return new ReadBookItem();
    int days = getDays(position);
    return new Stack(
      children: <Widget>[
        new Container(
          //height: screen.setWidth(145),
          margin: new EdgeInsets.fromLTRB(
              screen.setWidth(51),
              position == 0 ? screen.setWidth(40) : screen.setWidth(28),
              screen.setWidth(16),
              0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                color: Colors.white70,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                //卡片阴影
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 2.0)
              ]),

          child: new Container(
            margin: new EdgeInsets.only(top: screen.setWidth(10)),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //书名
                    new Container(
                      margin: new EdgeInsets.only(left: screen.setWidth(65)),
                      child: new Text(
                        _getStore().state.borrowBook == null
                            ? "暂无" : _getStore().state.borrowBook.data == null
                            ? "暂无" : _getStore().state.borrowBook.data[position].bookName == null
                            ? "暂无" : _getStore().state.borrowBook.data[position].bookName,
                        style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: screen.setSp(15),
                            fontWeight: FontWeight.bold),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    new Container(
                      alignment: Alignment.center,
                      margin: new EdgeInsets.only(right: screen.setWidth(14)),
                      decoration: new BoxDecoration(
                        color: Color(0xFF50BBD8),
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                      child: new GestureDetector(
                        onTap: () {
                          print('点击还书' + position.toString());
                          //getBackBook();
                          _openAddEntryDialog(
                            _getStore().state.borrowBook.data[position].id,
                          );
                        },
                        child: new Padding(
                          padding: new EdgeInsets.only(
                              left: screen.setWidth(10),
                              top: screen.setWidth(4),
                              right: screen.setWidth(10),
                              bottom: screen.setWidth(4)),
                          child: new Text(
                            '还书',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: screen.setSp(10)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //作者
                new Container(
                  margin: new EdgeInsets.only(
                      left: screen.setWidth(65), top: screen.setWidth(8)),
                  child: new Text(
                    _getStore().state.borrowBook == null
                        ? "" : _getStore().state.borrowBook.data == null
                        ? "" : _getStore().state.borrowBook.data[position].author == null
                        ? "" : _getStore().state.borrowBook.data[position].author,
                    style: TextStyle(
                        color: Color(0xFF303030), fontSize: screen.setSp(13)),
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.only(
                      left: screen.setWidth(65), top: screen.setWidth(8)),
                  child: new Text(
                    _getStore().state.borrowBook == null
                        ? "" : _getStore().state.borrowBook.data == null
                        ? "" : _getStore().state.borrowBook.data[position].startTime == null
                        ? "" : "借阅时间：" + new DateFormat('yyyy年MM月').format(
                        _getStore().state.borrowBook.data[position].startTime),
                    style: TextStyle(
                        color: Color(0xFFBBBBBB), fontSize: screen.setSp(12)),
                  ),
                ),

                new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(
                          left: screen.setWidth(65),
                          top: screen.setWidth(8),
                          bottom: screen.setWidth(10)),
                      //color: Colors.white70,

                      decoration: new BoxDecoration(
                        color:
                            days == 0 ? Color(0x0FDD412A) : Color(0x0F50BBD8),
                        border: new Border.all(
                          color:
                              days == 0 ? Color(0xFFDD412A) : Color(0xFF50BBD8),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: new Padding(
                        padding: new EdgeInsets.only(
                            left: screen.setWidth(14),
                            top: screen.setWidth(4),
                            right: screen.setWidth(14),
                            bottom: screen.setWidth(4)),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(
                                  top: screen.setWidth(1),
                                  bottom: screen.setWidth(1)),
                              child: new Text('剩余时间：',
                                  style: TextStyle(
                                    color: days == 0
                                        ? Color(0xFFDD412A)
                                        : Color(0xFF50BBD8),
                                    fontSize: screen.setSp(8),
                                  )),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(
                                  top: screen.setWidth(0),
                                  bottom: screen.setWidth(1)),
                              child: new Text(
                                days.toString(),
                                style: TextStyle(
                                  color: days == 0
                                      ? Color(0xFFDD412A)
                                      : Color(0xFF50BBD8),
                                  fontSize: screen.setSp(14),
                                ),
                              ),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(
                                  top: screen.setWidth(1),
                                  bottom: screen.setWidth(1)),
                              child: new Text('天',
                                  style: TextStyle(
                                    color: days == 0
                                        ? Color(0xFFDD412A)
                                        : Color(0xFF50BBD8),
                                    fontSize: screen.setSp(8),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Opacity(
                      opacity: days == 0 ? 1 : 0,
                      child: new Container(
                        margin: new EdgeInsets.only(left: screen.setWidth(6)),
                        alignment: Alignment.topLeft,
                        child: new Text(
                          '该还书了哟',
                          style: TextStyle(
                            color: Color(0xFFDD412A),
                            fontSize: screen.setSp(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        new Positioned(
          left: 16,
          top: position == 0 ? 24 : 12,
          bottom: 25,
          child: new FadeInImage.assetNetwork(
            placeholder: "images/mybg.jpeg", //预览图
            fit: BoxFit.fitWidth,
            image: "https://s2.ax1x.com/2019/05/10/E2jrr9.md.jpg",
            //image: "images/mybg.jpeg",
            width: screen.setWidth(90),
            height: screen.setWidth(132),
          ),
        ),
      ],
    );
  }

  BuildContext con;

  ///书评Dialog
  void _openAddEntryDialog(int borrowId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        con = ctx;
        return new Stack(
          children: <Widget>[
            new Container(
              width: 33,
              height: screen.setWidth(33),
              alignment: Alignment.topLeft,
              margin: new EdgeInsets.fromLTRB(
                  screen.setWidth(4), screen.setWidth(0), 0, 0),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new IconButton(
                    highlightColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    //padding: new EdgeInsets.all(screen.setWidth(13)),
                    alignment: Alignment.topLeft,
                    icon: new Icon(Icons.arrow_back_ios),
                    color: const Color(0xFFFFFFFF),
                    iconSize: screen.setWidth(23),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(
                screen.setWidth(30),
                screen.setWidth(70),
                screen.setWidth(30),
                screen.setWidth(55),
              ),
              decoration: new BoxDecoration(
                color: Color(0xFFFDFCF1),
                border: new Border.all(
                  color: Color(0xFFFDFCF1),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(
                    screen.setWidth(20),
                    screen.setWidth(23),
                    screen.setWidth(20),
                    screen.setWidth(23)),
                child: new Scaffold(
                  backgroundColor: Color(0xFFFDFCF1),
                  body: new TextField(
                    controller: _commentController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    maxLines: 20,
                    maxLength: 150,
                    style: new TextStyle(
                        color: Color(0xFF141414), fontSize: screen.setSp(15)),
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        counterText: "",
                        hintText: '请输入书评。。。',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(15))),
                    onChanged: (valueContent) {
                      _getStore()
                          .dispatch(new CheakContentAction(valueContent));
                    },
                  ),
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(
                  screen.setWidth(30), 0, screen.setWidth(30), 0),
              alignment: Alignment.bottomCenter,
              child: new GestureDetector(
                  onTap: () {
                    print('书评');
                    showCptDialog(borrowId);
                  },
                  child: new Container(
                    //color: Colors.white,
                    padding: new EdgeInsets.fromLTRB(
                        screen.setWidth(140),
                        screen.setWidth(10),
                        screen.setWidth(140),
                        screen.setWidth(10)),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: new Text('还书',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: screen.setWidth(15),
                            decoration: TextDecoration.none)),
                  )),
            ),
          ],
        );
      },
    );
  }

  ///发表书评并归还图书 Dialog
  void showCptDialog(int borrowId) {
    var dialog = CupertinoAlertDialog(
      content: Text(
        "确定发表书评并归还图书吗？",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text(
            "取消",
            style: TextStyle(
                color: Color(0xFF999999), fontSize: screen.setWidth(17)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text(
            "确定",
            style: TextStyle(
                color: Color(0xFF4990E2), fontSize: screen.setWidth(17)),
          ),
          onPressed: () {
            Navigator.pop(context);
            tag = true;
            toCommit(borrowId);
            //Navigator.pop(con);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  ///剩余阅读天数
  getDays(int position) {
    int days;
    DateTime now = DateTime.now();
    DateTime time = _getStore().state.borrowBook == null
        ? null
        : _getStore().state.borrowBook.data == null
            ? null
            : _getStore().state.borrowBook.data[position].endTime == null
                ? null
                : _getStore().state.borrowBook.data[position].endTime;
    if (time == null) {
      return days = 0;
    }
    //日期可通过isAfter或者isBefore判断日期的先后,通过difference()方法比较两个日期之间的差值
    if (now.isBefore(time)) {
      Duration duration = time.difference(now);
      //print("剩余天数" + duration.inDays.toString());
      days = duration.inDays;
    } else {
      return days = 0;
    }
    return days;
  }

  ///提交书评
  void toCommit(int borrowId) async {
    if (_getStore().state.commentBook != null &&
        _commentController.text.isNotEmpty) {
      await CommentBookActionCreator.commentBook(_getStore(), borrowId);
    } else {
      toShowDialog(2);
      return;
    }
  }

  void _onDidChange(Store<AppState> store) {
    if (tag && store.state.commentBook.commentError != null) {
      if (store.state.commentBook.commentError) {
        tag = false;
        Navigator.pop(context);
        _commentController.clear();
        BorrowBookActionCreator.getBorrowBook(_getStore());
        toShowDialog(1);
      } else {
        tag = false;
        toShowDialog(3);
      }
    }
  }

  void toShowDialog(int num) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return new TipsDialog(
            icon: new Icon(
              num == 1
                  ? Icons.check_circle_outline
                  : num == 2 ? Icons.highlight_off : Icons.highlight_off,
              size: 35,
              color: Colors.white,
            ),
            text: num == 1 ? "书籍归还成功" : num == 2 ? "书评内容不能为空" : "书籍归还失败",
          );
        });
    new Timer(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
