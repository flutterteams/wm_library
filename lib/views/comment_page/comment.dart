import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:wm_library/actions/comment.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/model/review/review.dart';

import 'add.dart';

class Comment extends StatelessWidget {
  Review review;

  Comment(this.review);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CommentHome(review),
    );
  }
}

class CommentHome extends StatefulWidget {
  Review review;

  CommentHome(this.review);

  @override
  _CommentHomeState createState() => _CommentHomeState();
}

class _CommentHomeState extends State<CommentHome> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CommentActionCreator.getCommentList(_getStore(), widget.review.id);
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
          child: new Stack(
            children: <Widget>[
              new Column(
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
                        0, screen.setWidth(20), 0, screen.setWidth(30)),
                  ),
                  store.state.comment == null
                      ? Container()
                      : new Expanded(
                          child: new CommentMain(isBlack, widget.review))
                ],
              ),
              new Positioned(
                  bottom: screen.setWidth(35),
                  right: screen.setWidth(20),
                  child: new Container(
                    width: screen.setWidth(46),
                    height: screen.setWidth(46),
                    decoration: BoxDecoration(
                        color: Color(0xff50bbd8),
                        borderRadius: BorderRadius.all(
                            Radius.circular(screen.setWidth(46)))),
                    child: new IconButton(
                        padding: new EdgeInsets.all(screen.setWidth(12)),
                        alignment: Alignment.center,
                        icon: new Icon(Icons.message),
                        color: Color(0xffffffff),
                        iconSize: screen.setWidth(22),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new AddComment(widget.review.id),
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ),
      );
    });
  }
}

class CommentMain extends StatefulWidget {
  bool isBlack;
  Review review;

  CommentMain(this.isBlack, this.review);

  @override
  _CommentMainState createState() => _CommentMainState();
}

class _CommentMainState extends State<CommentMain> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Column(
        children: <Widget>[
          new Container(
            width: screen.setWidth(325),
            padding: EdgeInsets.fromLTRB(screen.setWidth(20),
                screen.setWidth(16), screen.setWidth(20), screen.setWidth(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    new BorderRadius.all(Radius.circular(screen.setWidth(10)))),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: screen.setWidth(16)),
                  child: new Row(
                    children: <Widget>[
                      widget.review.url != null && widget.review.url != ''
                          ? new Container(
                              margin:
                                  EdgeInsets.only(right: screen.setWidth(13)),
                              width: screen.setWidth(40),
                              height: screen.setWidth(40),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screen.setWidth(40))),
                                image: new DecorationImage(
                                  image: NetworkImage(widget.review.url),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : new Container(
                              width: screen.setWidth(40),
                              height: screen.setWidth(40),
                              margin:
                                  EdgeInsets.only(right: screen.setWidth(13)),
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
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(bottom: screen.setWidth(3)),
                            child: new Text(
                              widget.review.name,
                              style: new TextStyle(
                                fontSize: screen.setSp(14),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          new Text(
                            new DateFormat('MM月dd日 hh:mm').format(
                                DateTime.parse(widget.review.create_time)),
                            style: new TextStyle(
                              fontSize: screen.setSp(12),
                              color: Color(0xff939393),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                new Text(
                  widget.review.content,
                  style: new TextStyle(
                      fontSize: screen.setSp(14),
                      color: Colors.black,
                      letterSpacing: screen.setWidth(0.09)),
                )
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(screen.setWidth(25),
                screen.setWidth(20), screen.setWidth(25), screen.setWidth(30)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Opacity(
                  opacity: 0.35,
                  child: new Container(
                    width: screen.setWidth(127),
                    height: screen.setWidth(1),
                    color: widget.isBlack
                        ? Color.fromRGBO(20, 20, 20, 0.3)
                        : Color.fromRGBO(255, 255, 255, 0.35),
                  ),
                ),
                new Opacity(
                  opacity: 0.6,
                  child: new Container(
                    child: new Text('回复',
                        style: new TextStyle(
                            fontSize: screen.setSp(14),
                            color: widget.isBlack ? Colors.black : Colors.white,
                            letterSpacing: screen.setWidth(1.2))),
                  ),
                ),
                new Opacity(
                  opacity: 0.35,
                  child: new Container(
                    width: screen.setWidth(127),
                    height: screen.setWidth(1),
                    color: widget.isBlack
                        ? Color.fromRGBO(20, 20, 20, 0.3)
                        : Color.fromRGBO(255, 255, 255, 0.35),
                  ),
                ),
              ],
            ),
          ),
          new CommentDetail(widget.isBlack)
        ],
      );
    });
  }
}

class CommentDetail extends StatefulWidget {
  bool isBlack;

  CommentDetail(this.isBlack);

  @override
  _CommentDetailState createState() => _CommentDetailState();
}

class _CommentDetailState extends State<CommentDetail> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      List list = store.state.comment;
      List<Widget> tiles = [];
      for (int i = 0; i < list.length; i++) {
        tiles.add(
          new Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(20)),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: screen.setWidth(48),
                  margin: EdgeInsets.fromLTRB(0, 0, screen.setWidth(7), 0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      list[i].url != null && list[i].url != ''
                          ? new Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, 0, 0, screen.setWidth(6)),
                              width: screen.setWidth(34),
                              height: screen.setWidth(34),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screen.setWidth(34))),
                                image: new DecorationImage(
                                  image: NetworkImage(list[i].url),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : new Container(
                              width: screen.setWidth(34),
                              height: screen.setWidth(34),
                              margin: EdgeInsets.fromLTRB(
                                  0, 0, 0, screen.setWidth(6)),
                              decoration: new BoxDecoration(
                                color: Color(0xffeeeeee),
                                border: Border.all(
                                    color: Color.fromRGBO(0, 0, 0, 0.07)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screen.setWidth(34))),
                              ),
                              child: new Icon(
                                Icons.person,
                                size: screen.setWidth(28),
                                color: const Color(0xffd2d2d2),
                              ),
                            ),
                      new Opacity(
                        opacity: 0.5,
                        child: new Text(list[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: screen.setSp(12),
                              color:
                                  widget.isBlack ? Colors.black : Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
                new Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(117, 188, 255, 0.15)
                  ),
                  width: screen.setWidth(230),
                  padding: EdgeInsets.fromLTRB(
                      screen.setWidth(30),
                      screen.setWidth(16),
                      screen.setWidth(16),
                      screen.setWidth(8)),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Opacity(
                        opacity: 0.8,
                        child: new Container(
                          margin: EdgeInsets.only(bottom: screen.setWidth(18)),
                          child: new Text(
                            list[i].content,
                            style: new TextStyle(
                                fontSize: screen.setSp(13),
                                color: widget.isBlack
                                    ? Colors.black
                                    : Colors.white,
                                letterSpacing: screen.setWidth(0.09)),
                          ),
                        ),
                      ),
                      new Opacity(
                          opacity: 0.6,
                          child: new Text(
                              new DateFormat('MM月dd日 hh:mm')
                                  .format(DateTime.parse(list[i].create_time)),
                              style: new TextStyle(
                                fontSize: screen.setSp(11),
                                color: widget.isBlack
                                    ? Colors.black
                                    : Colors.white,
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
      return new Expanded(
          child: list.length == 0
              ? new Container(
                  margin: EdgeInsets.only(top: screen.setWidth(24)),
                  child: new Text(
                    '暂无回复',
                    style: new TextStyle(
                        fontSize: screen.setSp(15),
                        color: widget.isBlack ? Colors.black : Colors.white,
                        letterSpacing: screen.setWidth(0.1)),
                  ),
                )
              : new ListView(
                  padding: EdgeInsets.fromLTRB(screen.setWidth(18), 0,
                      screen.setWidth(72), screen.setWidth(20)),
                  children: <Widget>[
                    new Column(
                      children: tiles,
                    )
                  ],
                ));
    });
  }
}
