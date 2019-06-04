import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:wm_library/actions/detail.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/views/comment_page/comment.dart';
import 'package:wm_library/views/order_page/order.dart';

class Detail extends StatelessWidget {
  int id;

  Detail(this.id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DetailHome(id),
    );
  }
}

class DetailHome extends StatefulWidget {
  int id;

  DetailHome(this.id);

  @override
  _DetailHomeState createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    DetailActionCreator.getData(_getStore(), widget.id);
    DetailActionCreator.getReviewList(_getStore(), widget.id);
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      bool isBlack = store.state.detail['book'] == null
          ? false
          : store.state.detail['book'].foreground == 'black' ? true : false;
      return new Scaffold(
        body: new Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(isBlack ? 0xffFACF3C : 0xff438ae2),
          child: new Column(
            children: <Widget>[
              new Container(
                height: screen.setWidth(33),
                child: new IconButton(
                    padding: new EdgeInsets.all(screen.setWidth(13)),
                    alignment: Alignment.topLeft,
                    icon: new Icon(Icons.arrow_back_ios),
                    color: Color(isBlack ? 0xff5E4B00 : 0xffffffff),
                    iconSize: screen.setWidth(20),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                alignment: Alignment.topLeft,
                margin: new EdgeInsets.fromLTRB(
                    0, screen.setWidth(20), 0, screen.setWidth(16)),
              ),
              store.state.detail['book'] == null
                  ? new Container()
                  : new DetailMain(isBlack)
            ],
          ),
        ),
      );
    });
  }
}

class DetailMain extends StatefulWidget {
  bool isBlack;

  DetailMain(this.isBlack);

  @override
  _DetailMainState createState() => _DetailMainState();
}

class _DetailMainState extends State<DetailMain> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Expanded(
          child: new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
                margin: EdgeInsets.fromLTRB(
                    0, screen.setWidth(85), 0, screen.setWidth(14)),
                width: screen.setWidth(325),
                decoration: new BoxDecoration(
                    color: widget.isBlack
                        ? Color.fromRGBO(255, 246, 205, 0.3)
                        : Color.fromRGBO(117, 188, 255, 0.15),
                    borderRadius: new BorderRadius.all(
                        Radius.circular(screen.setWidth(10)))),
                child: new Container(
                  margin: EdgeInsets.only(top: screen.setWidth(101)),
                  child: new ListView(
                    padding: EdgeInsets.fromLTRB(screen.setWidth(20), 0,
                        screen.setWidth(20), screen.setWidth(10)),
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new BookTitle(widget.isBlack),
                          new Container(
                            height: screen.setWidth(1),
                            color: widget.isBlack
                                ? Color.fromRGBO(20, 20, 20, 0.3)
                                : Color.fromRGBO(255, 255, 255, 0.35),
                          ),
                          new Intro(widget.isBlack),
                          new Container(
                            height: screen.setWidth(1),
                            color: widget.isBlack
                                ? Color.fromRGBO(20, 20, 20, 0.3)
                                : Color.fromRGBO(255, 255, 255, 0.35),
                          ),
                          new Review(widget.isBlack),
                        ],
                      ),
                    ],
                  ),
                )),
            new Positioned(
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: widget.isBlack
                          ? Color(0xff141414)
                          : Colors.transparent),
                ),
                child: new Image.network(
                  store.state.detail['book'].url == null
                      ? 'https://gd1.alicdn.com/imgextra/i1/2418395878/TB2G1jFFHGYBuNjy0FoXXciBFXa_!!2418395878.jpg'
                      : store.state.detail['book'].url,
                  width: screen.setWidth(130),
                  height: screen.setWidth(170),
                  fit: BoxFit.cover,
                ),
              ),
              top: 0,
              left: screen.setWidth(98),
            )
          ],
        ),
      ));
    });
  }
}

class BookTitle extends StatefulWidget {
  bool isBlack;

  BookTitle(this.isBlack);

  @override
  _BookTitleState createState() => _BookTitleState();
}

class _BookTitleState extends State<BookTitle> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      List typeList = store.state.index.typeList;
      String name = '';

      // 计算上面推荐子标题显示内容
      for (int i = 0; i < typeList.length; i++) {
        if (store.state.detail['book'].type_id == typeList[i]['id']) {
          name = typeList[i]['name'];
        }
      }
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(11)),
            child: new Text(
              store.state.detail['book'].title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: new TextStyle(
                fontSize: screen.setSp(20),
                color: widget.isBlack ? Color(0xff141414) : Colors.white,
                letterSpacing: screen.setWidth(0.5),
              ),
            ),
          ),
          new Opacity(
            opacity: 0.6,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  constraints: BoxConstraints(maxWidth: screen.setWidth(165)),
                  child: new Text(
                    store.state.detail['book'].author,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: new TextStyle(
                      fontSize: screen.setSp(13),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                      letterSpacing: screen.setWidth(0.4),
                    ),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(
                      screen.setWidth(13), 0, screen.setWidth(13), 0),
                  width: screen.setWidth(1),
                  height: screen.setWidth(12),
                  color: widget.isBlack ? Color(0xff141414) : Color(0xffd8d8d8),
                ),
                new Container(
                  constraints: BoxConstraints(maxWidth: screen.setWidth(100)),
                  child: new Text(
                    '分类：$name',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: new TextStyle(
                      fontSize: screen.setSp(13),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                      letterSpacing: screen.setWidth(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Order(store.state.detail['book'].id),
                ),
              );
            },
            child: new Container(
              margin: EdgeInsets.fromLTRB(
                  0, screen.setWidth(20), 0, screen.setWidth(24)),
              width: screen.setWidth(96),
              height: screen.setWidth(30),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                  border: new Border.all(
                      color: widget.isBlack ? Color(0xff141414) : Colors.white),
                  borderRadius:
                      BorderRadius.all(Radius.circular(screen.setWidth(15)))),
              child: new Text('我要借阅',
                  style: new TextStyle(
                    fontSize: screen.setSp(15),
                    color: widget.isBlack ? Color(0xff141414) : Colors.white,
                  )),
            ),
          ),
        ],
      );
    });
  }
}

class Intro extends StatefulWidget {
  bool isBlack;

  Intro(this.isBlack);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Column(
        children: <Widget>[
          new Opacity(
            opacity: 0.6,
            child: new Container(
              margin: EdgeInsets.fromLTRB(
                  0, screen.setWidth(21), 0, screen.setWidth(15)),
              child: new Text('本书简介',
                  style: new TextStyle(
                    fontSize: screen.setSp(18),
                    color: widget.isBlack ? Color(0xff141414) : Colors.white,
                    letterSpacing: screen.setWidth(0.45),
                  )),
            ),
          ),
          new Container(
            child: new Text(store.state.detail['book'].content,
                overflow: isShow ? null : TextOverflow.ellipsis,
                maxLines: isShow ? null : 7,
                style: new TextStyle(
                  fontSize: screen.setSp(14),
                  color: widget.isBlack ? Color(0xff141414) : Colors.white,
                  height: 1,
                  letterSpacing: screen.setWidth(0.09),
                )),
          ),
          isShow
              ? new Container(
                  height: screen.setWidth(16),
                )
              : new Opacity(
                  opacity: 0.6,
                  child: new Container(
                      height: screen.setWidth(34),
                      child: new Transform.rotate(
                        angle: -math.pi / 2,
                        child: new IconButton(
                            padding: new EdgeInsets.all(screen.setWidth(12)),
                            alignment: Alignment.center,
                            icon: new Icon(Icons.arrow_back_ios),
                            color: widget.isBlack
                                ? Color(0xff141414)
                                : Colors.white,
                            iconSize: screen.setWidth(18),
                            onPressed: () {
                              setState(() {
                                isShow = true;
                              });
                            }),
                      )))
        ],
      );
    });
  }
}

class Review extends StatefulWidget {
  bool isBlack;

  Review(this.isBlack);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      List list = store.state.detail['list'];
      if (list != null) {
        List<Widget> tiles = [];
        for (int i = 0; i < list.length; i++) {
          tiles.add(new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Comment(list[i]),
                ),
              );
            },
            child: new Container(
              color: Colors.transparent,
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: screen.setWidth(18)),
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            list[i].url != null && list[i].url != ''
                                ? new Container(
                                    margin: EdgeInsets.only(
                                        right: screen.setWidth(13)),
                                    width: screen.setWidth(40),
                                    height: screen.setWidth(40),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(screen.setWidth(40))),
                                      image: new DecorationImage(
                                        image: NetworkImage(list[i].url),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : new Container(
                                    margin: EdgeInsets.only(
                                        right: screen.setWidth(13)),
                                    width: screen.setWidth(40),
                                    height: screen.setWidth(40),
                                    decoration: new BoxDecoration(
                                      color: Color(0xffeeeeee),
                                      border: Border.all(
                                          color: Color.fromRGBO(0, 0, 0, 0.07)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(screen.setWidth(40))),
                                    ),
                                    child: new Icon(
                                      Icons.person,
                                      size: screen.setWidth(28),
                                      color: const Color(0xffd2d2d2),
                                    ),
                                  ),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(
                                        bottom: screen.setWidth(3)),
                                    child: new Text(list[i].name,
                                        style: new TextStyle(
                                          fontSize: screen.setSp(14),
                                          color: widget.isBlack
                                              ? Color(0xff141414)
                                              : Colors.white,
                                        )),
                                  ),
                                  new Opacity(
                                      opacity: 0.6,
                                      child: new Text(
                                          new DateFormat('MM月dd日 hh:mm').format(
                                              DateTime.parse(
                                                  list[i].create_time)),
                                          style: new TextStyle(
                                              fontSize: screen.setSp(12),
                                              color: widget.isBlack
                                                  ? Color(0xff141414)
                                                  : Colors.white))),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  new Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(
                        0, screen.setWidth(16), 0, screen.setWidth(11)),
                    child: new Text(
                      list[i].content,
                      style: new TextStyle(
                          fontSize: screen.setSp(14),
                          letterSpacing: screen.setWidth(0.09),
                          color: widget.isBlack
                              ? Color(0xff141414)
                              : Colors.white),
                    ),
                  ),
                  new Opacity(
                    opacity: 0.6,
                    child: new Container(
                      margin: EdgeInsets.only(bottom: screen.setWidth(17)),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(right: screen.setWidth(6)),
                            child: new Icon(
                              Icons.sms,
                              size: screen.setWidth(16),
                              color: widget.isBlack
                                  ? Color(0xff141414)
                                  : Colors.white,
                            ),
                          ),
                          new Text(list[i].count.toString(),
                              style: new TextStyle(
                                  fontSize: screen.setSp(14),
                                  letterSpacing: screen.setWidth(0.09),
                                  color: widget.isBlack
                                      ? Color(0xff141414)
                                      : Colors.white))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
          if (i < list.length - 1) {
            tiles.add(
              new Container(
                height: screen.setWidth(1),
                color: widget.isBlack
                    ? Color.fromRGBO(20, 20, 20, 0.3)
                    : Color.fromRGBO(255, 255, 255, 0.35),
              ),
            );
          }
        }

        return new Column(
          children: <Widget>[
            new Opacity(
              opacity: 0.6,
              child: new Container(
                margin: EdgeInsets.fromLTRB(0, screen.setWidth(21), 0, 0),
                child: new Text('书评',
                    style: new TextStyle(
                      fontSize: screen.setSp(18),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                      letterSpacing: screen.setWidth(0.45),
                    )),
              ),
            ),
            list.length == 0
                ? new Container(
                    margin: EdgeInsets.fromLTRB(
                        0, screen.setWidth(16), 0, screen.setWidth(24)),
                    child: new Text(
                      '暂无内容',
                      style: new TextStyle(
                        fontSize: screen.setSp(14),
                        color:
                            widget.isBlack ? Color(0xff141414) : Colors.white,
                        letterSpacing: screen.setWidth(0.09),
                      ),
                    ),
                  )
                : new Column(
                    children: tiles,
                  )
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
