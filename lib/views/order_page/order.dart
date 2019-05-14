import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:wm_library/actions/order.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

class Order extends StatelessWidget {
  int id;

  Order(this.id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new OrderHome(id),
    );
  }
}

class OrderHome extends StatefulWidget {
  int id;

  OrderHome(this.id);

  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    OrderActionCreator.getOrderList(_getStore(), widget.id);
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
        body: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Column(
            children: <Widget>[
              new Container(
                height: screen.setWidth(33),
                child: new IconButton(
                    padding: new EdgeInsets.all(screen.setWidth(13)),
                    alignment: Alignment.topLeft,
                    icon: new Icon(Icons.arrow_back_ios),
                    color: Color(0xff424242),
                    iconSize: screen.setWidth(20),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                alignment: Alignment.topLeft,
                margin: new EdgeInsets.fromLTRB(
                    0, screen.setWidth(20), 0, screen.setWidth(27)),
              ),
              store.state.order == null
                  ? new Container()
                  : new OrderMain(widget.id)
            ],
          ),
        ),
      );
    });
  }
}

class OrderMain extends StatefulWidget {
  int id;

  OrderMain(this.id);

  @override
  _OrderMainState createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      List list = store.state.order;
      List<Widget> tiles = [];

      for (int i = 0; i < list.length; i++) {
        Color top = Color(0xffbbbbbb);
        Color left = Color(0xffbbbbbb);
        Color right = Color(0xffbbbbbb);
        Color bottom = Color(0xffbbbbbb);
        bool isNight = list[i].status == 0 ? true : false;

        if (i == 0 && list[i].status == -1) {
          DateTime date = new DateTime.now();
          if (date.day > 25) {
            isNight = true;
          }
        }

        if (isNight) {
          left = Color(0xffe0e0e0);

          if (i < 2) {
            top = Color(0xffe0e0e0);
          }

          if (i % 2 == 0) {
            if (list[i + 1].status == 0) {
              right = Color(0xffe0e0e0);
            }
          } else {
            right = Color(0xffe0e0e0);
          }

          if (i < list.length - 2) {
            if (list[i + 2].status == 0) {
              bottom = Color(0xffe0e0e0);
            }
          } else {
            bottom = Color(0xffe0e0e0);
          }
        }

        if (i % 2 == 1) {
          left = null;
        }

        if (i > 1) {
          top = null;
        }

        tiles.add(new Container(
          width: screen.setWidth(160),
          height: screen.setWidth(130),
          padding: EdgeInsets.fromLTRB(screen.setWidth(12), screen.setWidth(10),
              screen.setWidth(9), screen.setWidth(8)),
          decoration: BoxDecoration(
              color: isNight ? Color(0xfffafafa) : Colors.white,
              border: Border(
                top: top == null ? BorderSide.none : BorderSide(color: top),
                left: left == null ? BorderSide.none : BorderSide(color: left),
                right:
                    right == null ? BorderSide.none : BorderSide(color: right),
                bottom: bottom == null
                    ? BorderSide.none
                    : BorderSide(color: bottom),
              )),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Opacity(
                            opacity: isNight ? 0.3 : 1,
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  list[i].borrow_month.toString(),
                                  style: new TextStyle(
                                      fontSize: screen.setSp(32),
                                      letterSpacing: screen.setWidth(0.21),
                                      color: Color(0xff141414),
                                      height: 1),
                                ),
                                new Container(
                                  transform: Matrix4.translationValues(
                                      0, screen.setWidth(4), 0),
                                  margin: EdgeInsets.only(
                                      right: screen.setWidth(4)),
                                  child: new Text(
                                    '月',
                                    style: new TextStyle(
                                        fontSize: screen.setSp(16),
                                        letterSpacing: screen.setWidth(0.11),
                                        color: Color(0xff141414),
                                        height: 1),
                                  ),
                                ),
                                new Container(
                                  transform: Matrix4.translationValues(
                                      0, screen.setWidth(5), 0),
                                  child: new Text(
                                    '${list[i].borrow_year.toString()}年',
                                    style: new TextStyle(
                                        fontSize: screen.setSp(10),
                                        letterSpacing: screen.setWidth(0.07),
                                        color: Color(0xff141414),
                                        height: 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(4)),
                    child: new Row(
                      children: <Widget>[
                        new Opacity(
                          opacity: isNight ? 0.4 : 1,
                          child: new Container(
                            margin: EdgeInsets.only(right: screen.setWidth(12)),
                            child: new Text(
                              '借阅状态：',
                              style: new TextStyle(
                                  fontSize: screen.setSp(12),
                                  letterSpacing: screen.setWidth(0.08),
                                  color: Color(0xff424242),
                                  height: 1),
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            if (!isNight) {
                              show(store, list[i]);
                            }
                          },
                          child: new Text(
                            isNight
                                ? i == 0
                                    ? list[i].status == 0 ? '已借出' : '不可预约'
                                    : '已预约'
                                : list[i].status == -1 ? '借书' : '预约',
                            style: new TextStyle(
                                fontSize: screen.setSp(14),
                                color: isNight
                                    ? Color(0xffbbbbbb)
                                    : Color(0xff50bbd8),
                                height: 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Opacity(
                    opacity: isNight ? 0.4 : 1,
                    child: new Container(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: new Text(
                              '借阅人：',
                              style: new TextStyle(
                                  fontSize: screen.setSp(12),
                                  letterSpacing: screen.setWidth(6),
                                  color: Color(0xff424242),
                                  height: 1),
                            ),
                          ),
                          new Text(
                            list[i].name == '' || list[i].name == null
                                ? '无'
                                : list[i].name,
                            style: new TextStyle(
                                fontSize: screen.setSp(12),
                                letterSpacing: screen.setWidth(0.08),
                                color: Color(0xff424242),
                                height: 1),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
      }

      return new Container(
        padding: EdgeInsets.fromLTRB(screen.setWidth(28), 0, 0, 0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: screen.setWidth(32)),
              child: new Text(
                '预约图书',
                style: new TextStyle(
                    fontSize: screen.setSp(30), color: Color(0xff212121)),
              ),
            ),
            tiles.length > 0
                ? new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[tiles[0], tiles[1]],
                      ),
                      new Row(
                        children: <Widget>[tiles[2], tiles[3]],
                      ),
                      new Row(
                        children: <Widget>[tiles[4], tiles[5]],
                      )
                    ],
                  )
                : Container(),
            new Container(
              margin: EdgeInsets.only(top: screen.setWidth(32)),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      '提示：',
                      style: new TextStyle(
                          fontSize: screen.setSp(12),
                          color: Color(0xff999999),
                          height: 1),
                    ),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(bottom: screen.setWidth(3)),
                        child: new Text(
                          '1.每月25日之后不可借阅当前月份的书籍；',
                          style: new TextStyle(
                              fontSize: screen.setSp(12),
                              color: Color(0xff999999),
                              height: 1),
                        ),
                      ),
                      new Text(
                        '2.每人每月只可借阅一本书籍；',
                        style: new TextStyle(
                            fontSize: screen.setSp(12),
                            color: Color(0xff999999),
                            height: 1),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void show(store, obj) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('确定预约吗？'),
            actions: <Widget>[
              new CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消',
                    style: new TextStyle(
                        fontSize: screen.setSp(17),
                        color: Color(0xff999999)),
                  )),
              new CupertinoButton(
                  onPressed: () {
                    OrderActionCreator.postOrder(
                        store,
                        widget.id,
                        '${obj.borrow_year}-${obj.borrow_month}',
                            (data) {
                          if (data['id'] == '10001') {
                            showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return CupertinoAlertDialog(
                                    title: Text(data['text']),
                                    actions: <Widget>[
                                      new CupertinoButton(
                                          onPressed: () {
                                            Navigator.of(
                                                context)
                                                .pop();
                                          },
                                          child: Text(
                                            '确定',
                                            style: new TextStyle(
                                                fontSize:
                                                screen.setSp(
                                                    17),
                                                color: Color(
                                                    0xff4990e2)),
                                          )),
                                    ],
                                  );
                                });
                          } else {
                            print('跳转到我的书籍');
                          }
                        });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '确定',
                    style: new TextStyle(
                        fontSize: screen.setSp(17),
                        color: Color(0xff4990e2)),
                  )),
            ],
          );
        });
  }
}
