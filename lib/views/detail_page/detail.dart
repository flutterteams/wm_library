import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/actions/index.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/views/index_page/type.dart';

class Detail extends StatelessWidget {
  int id;

  Detail(this.id);

  @override
  Widget build(BuildContext context) {
    print(id);
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
  Widget build(BuildContext context) {
    bool isBlack = true;
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
            new DetailMain(isBlack)
          ],
        ),
      ),
    );
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                'https://gd1.alicdn.com/imgextra/i1/2418395878/TB2G1jFFHGYBuNjy0FoXXciBFXa_!!2418395878.jpg',
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
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(11)),
          child: new Text(
            '代码整洁知道代码整洁知道代码整洁知道代码整洁知道',
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
              new Text(
                '[美] Robert C. Martin',
                style: new TextStyle(
                  fontSize: screen.setSp(13),
                  color: widget.isBlack ? Color(0xff141414) : Colors.white,
                  letterSpacing: screen.setWidth(0.4),
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(
                    screen.setWidth(13), 0, screen.setWidth(13), 0),
                width: screen.setWidth(1),
                height: screen.setWidth(12),
                color: widget.isBlack ? Color(0xff141414) : Color(0xffd8d8d8),
              ),
              new Text(
                '分类：IT技术',
                style: new TextStyle(
                  fontSize: screen.setSp(13),
                  color: widget.isBlack ? Color(0xff141414) : Colors.white,
                  letterSpacing: screen.setWidth(0.4),
                ),
              ),
            ],
          ),
        ),
        new GestureDetector(
          onTap: () {
            print('我要节约');
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
  }
}

class Intro extends StatefulWidget {
  bool isBlack;

  Intro(this.isBlack);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
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
          child: new Text(
              '本书提出一种观念：代码质量与其整洁度成正比。干净的代码，既在质量上较为可靠，也为后期维护、升级奠定了良好基础。作为编程领域的佼佼者，本书作者给出了一系列行之有效的整洁代码操作实践。这些实践在本书中体现为一条条规则(或称“启示”)，并辅以来自现实项目的正、反两面的范例,并辅以来自现实项目的正、反两面的范例,并辅以来自现实项目的正、反两面的范例并辅以来自现实项目的正、反两面的范例',
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
              style: new TextStyle(
                fontSize: screen.setSp(14),
                color: widget.isBlack ? Color(0xff141414) : Colors.white,
                height: 1,
                letterSpacing: screen.setWidth(0.09),
              )),
        ),
        new Opacity(
            opacity: 0.6,
            child: new Container(
                height: screen.setWidth(34),
                child: new Transform.rotate(
                  angle: -math.pi / 2,
                  child: new IconButton(
                      padding: new EdgeInsets.all(screen.setWidth(12)),
                      alignment: Alignment.center,
                      icon: new Icon(Icons.arrow_back_ios),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                      iconSize: screen.setWidth(18),
                      onPressed: () {
                        print('全部');
                      }),
                )))
      ],
    );
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
        new GestureDetector(
          onTap: () {
            print('详情');
          },
          child: new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: screen.setWidth(18)),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(right: screen.setWidth(13)),
                          width: screen.setWidth(40),
                          height: screen.setWidth(40),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screen.setWidth(40))),
                            image: new DecorationImage(
                              image: NetworkImage(
                                  'https://gd1.alicdn.com/imgextra/i1/2418395878/TB2G1jFFHGYBuNjy0FoXXciBFXa_!!2418395878.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text('人名',
                                    style: new TextStyle(
                                      fontSize: screen.setSp(14),
                                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                                    )),
                              ),
                              new Opacity(
                                  opacity: 0.6,
                                  child: new Text('01月18日 20:00',
                                      style: new TextStyle(
                                          fontSize: screen.setSp(12),
                                          color: widget.isBlack ? Color(0xff141414) : Colors.white))),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(
                    0, screen.setWidth(16), 0, screen.setWidth(11)),
                child: new Text(
                  '这是一本真正的好书，不过如果读者没有一定的经验，以及缺乏对编程境界的追求的话，可能认为这本书很一般，甚至认为只是说了一些大白话。',
                  style: new TextStyle(
                      fontSize: screen.setSp(14),
                      letterSpacing: screen.setWidth(0.09),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white),
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
                          color: widget.isBlack ? Color(0xff141414) : Colors.white,
                        ),
                      ),
                      new Text('10',
                          style: new TextStyle(
                              fontSize: screen.setSp(14),
                              letterSpacing: screen.setWidth(0.09),
                              color: widget.isBlack ? Color(0xff141414) : Colors.white))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        new Container(
          height: screen.setWidth(1),
          color: widget.isBlack
              ? Color.fromRGBO(20, 20, 20, 0.3)
              : Color.fromRGBO(255, 255, 255, 0.35),
        ),
        new GestureDetector(
          onTap: () {
            print('详情');
          },
          child: new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: screen.setWidth(18)),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(right: screen.setWidth(13)),
                          width: screen.setWidth(40),
                          height: screen.setWidth(40),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screen.setWidth(40))),
                            image: new DecorationImage(
                              image: NetworkImage(
                                  'https://gd1.alicdn.com/imgextra/i1/2418395878/TB2G1jFFHGYBuNjy0FoXXciBFXa_!!2418395878.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text('人名',
                                    style: new TextStyle(
                                      fontSize: screen.setSp(14),
                                      color: widget.isBlack ? Color(0xff141414) : Colors.white,
                                    )),
                              ),
                              new Opacity(
                                  opacity: 0.6,
                                  child: new Text('01月18日 20:00',
                                      style: new TextStyle(
                                          fontSize: screen.setSp(12),
                                          color: widget.isBlack ? Color(0xff141414) : Colors.white))),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(
                    0, screen.setWidth(16), 0, screen.setWidth(11)),
                child: new Text(
                  '这是一本真正的好书，不过如果读者没有一定的经验，以及缺乏对编程境界的追求的话，可能认为这本书很一般，甚至认为只是说了一些大白话。',
                  style: new TextStyle(
                      fontSize: screen.setSp(14),
                      letterSpacing: screen.setWidth(0.09),
                      color: widget.isBlack ? Color(0xff141414) : Colors.white),
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
                          color: widget.isBlack ? Color(0xff141414) : Colors.white,
                        ),
                      ),
                      new Text('10',
                          style: new TextStyle(
                              fontSize: screen.setSp(14),
                              letterSpacing: screen.setWidth(0.09),
                              color: widget.isBlack ? Color(0xff141414) : Colors.white))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
