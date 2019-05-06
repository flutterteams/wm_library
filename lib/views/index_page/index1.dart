import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/actions/login.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new IndexHome(),
    );
  }
}

class IndexHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Container(
          child: new Column(
            children: <Widget>[
              new IndexTop(),
              new IndexTitle(),
              new IndexMain(),
              new BookTitle(),
            ],
          ),
        ),
        new IndexTo()
      ],
    );
  }
}

/// 顶部导航
class IndexTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          screen.setWidth(13), screen.setWidth(34), screen.setWidth(13), 0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(
                      0, screen.setWidth(9), 0, screen.setWidth(10)),
                  height: screen.setWidth(2),
                  width: screen.setWidth(22),
                  color: const Color(0xff424242),
                ),
                new Container(
                  height: screen.setWidth(2),
                  width: screen.setWidth(22),
                  color: const Color(0xff424242),
                )
              ],
            ),
          ),
          new Container(
            width: screen.setWidth(32),
            height: screen.setWidth(32),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: const Color(0xffeeeeee),
                border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.07)),
                borderRadius:
                    new BorderRadius.all(Radius.circular(screen.setWidth(32)))),
            child: new Icon(
              Icons.person,
              size: screen.setWidth(22),
              color: const Color(0xffd2d2d2),
            ),
          )
        ],
      ),
    );
  }
}

/// 书分类标题
class IndexTitle extends StatefulWidget {
  @override
  _IndexTitleState createState() => _IndexTitleState();
}

class _IndexTitleState extends State<IndexTitle> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.fromLTRB(
          screen.setWidth(27), 0, 0, screen.setWidth(24)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: screen.setWidth(30),
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(15), 0, screen.setWidth(14)),
            child: new Text(
              '推荐',
              style: new TextStyle(
                  color: const Color(0xff212121),
                  fontSize: screen.setSp(30),
                  height: 1,
                  fontWeight: FontWeight.w500),
            ),
          ),
          new Container(
            height: screen.setWidth(24),
            child: new Text('IT技术',
                style: new TextStyle(
                  color: const Color(0xff424242),
                  fontSize: screen.setSp(24),
                  height: 1,
                )),
          )
        ],
      ),
    );
  }
}

class IndexMain extends StatefulWidget {
  @override
  _IndexMainState createState() => _IndexMainState();
}

class _IndexMainState extends State<IndexMain> with TickerProviderStateMixin {
  double startX = 0;
  double startY = 0;
  double moveX = 0;
  double moveY = 0;
  double endX = 0;
  double endY = 0;

  double move = 0; // 每一次的移动距离的叠加
  double index = 0; // 当前展示的图片序号
  bool isPrevMove = false; // 是否是返回前一张

  double preMove = 0; // 记录上一次移动距离的叠加

  double defaultMove = screen.setWidth(243); // 默认图片移动到页面外的移动距离
  double defaultScaleL = 0.7; // 默认图片移动到页面外缩放的比例
  double defaultScaleR = 0.8; // 默认首张图片下面的图片的缩放比例
  double defaultOpacity = 0.4; // 默认透明度

  double defaultWidth = screen.setWidth(270); // 初始化图片宽度
  double defaultHeight = screen.setWidth(370); // 初始化图片高度

  Animation<double> animation;
  AnimationController controller;

  var arr = [
    {
      'imgUrl':
          'https://img.alicdn.com/imgextra/i1/1917047079/TB1zpA1XxTpK1RjSZFKXXa2wXXa_!!0-item_pic.jpg_430x430q90.jpg',
      'title': 'CCC',
      'description': 'cccccc | 1234'
    },
    {
      'imgUrl':
          'https://img.alicdn.com/imgextra/i4/1917047079/TB20BE0XzDpK1RjSZFrXXa78VXa_!!1917047079.jpg_430x430q90.jpg',
      'title': 'AAA',
      'description': 'aaaaaa | 1234'
    },
    {
      'imgUrl':
          'https://img.alicdn.com/imgextra/i3/1917047079/TB2xJ31Xq6qK1RjSZFmXXX0PFXa_!!1917047079.jpg_430x430q90.jpg',
      'title': 'BBB',
      'description': 'bbbbbb | 1234'
    },
    {
      'imgUrl':
          'https://img.alicdn.com/imgextra/i4/1917047079/TB2xhg2XAPoK1RjSZKbXXX1IXXa_!!1917047079.jpg_430x430q90.jpg',
      'title': 'DDD',
      'description': 'dddddd | 1234'
    }
  ];

  void moveStart(e) {
    startX = e.globalPosition.dx;
    startY = e.globalPosition.dy;
  }

  void moveUpdate(e) {
    double _moveT = 0;

    moveX = e.globalPosition.dx;
    moveY = e.globalPosition.dy;

    if ((moveX - startX).abs() > (moveY - startY).abs()) {
      print('水平');
      if (moveX - startX > 0) {
        print('向右移动');
        isPrevMove = true;
        if (index == 0) {
          return;
        }
      } else {
        print('向左移动');
        isPrevMove = false;
        if (index == arr.length - 1) {
          return;
        }
      }

      _moveT = preMove + screen.setWidth(moveX - startX);

      setState(() {
        move = _moveT;
      });
    } else {
      print('垂直');
    }
  }

  void moveEnd(e) {
    // 判断手指离开, 是否移动

    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation =
        new Tween(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();

    print(animation);

    if (moveX - startX < -screen.setWidth(375) / 5 && index < arr.length - 1) {
      index = index + 1;
      setState(() {
        move = -defaultMove * index;
      });
      preMove = -defaultMove * index;
    } else if (moveX - startX > screen.setWidth(375) / 5 && index > 0) {
      index = index - 1;
      setState(() {
        move = -defaultMove * index;
      });
      preMove = -defaultMove * index;
    } else {
      setState(() {
        move = -defaultMove * index;
      });
      preMove = -defaultMove * index;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    for (int i = arr.length - 1; i >= 0; i--) {
      double _scale = 1;
      double _move = 0;
      double _opacity = 0;

      double _move1 =
          defaultWidth - defaultWidth * defaultScaleR + screen.setWidth(26);

      double _move2 = defaultWidth -
          defaultWidth * defaultScaleR * defaultScaleR +
          screen.setWidth(52);

      // 判断位移和缩放比例
      if (i > index) {
        // 计算当前页的下一张移动情况
        if (i == index + 1) {
          // 只有2张图片的情况
          if (arr.length == 2) {
            _move1 = defaultWidth -
                defaultWidth * defaultScaleR +
                screen.setWidth(52);
          }

          double _moveT1 =
              (defaultMove * (index + 1) + move) / defaultMove * _move1;
          double _scaleT1 = 1 -
              (defaultMove * (index + 1) + move) /
                  defaultMove *
                  (1 - defaultScaleR);
          double _opacityT1 =
              (defaultMove * (index + 1) + move) / defaultMove * defaultOpacity;
          _move = _moveT1 > _move1 ? _move1 : _moveT1 < 0 ? 0 : _moveT1;
          _scale = _scaleT1 > 1
              ? 1
              : _scaleT1 < defaultScaleR ? defaultScaleR : _scaleT1;
          _opacity = _opacityT1 < 0
              ? 0
              : _opacityT1 > defaultOpacity ? defaultOpacity : _opacityT1;

          // 如果当前页是返回前一张的话
          if (isPrevMove) {
            double _moveT4 = (_move2 - _move1) *
                    (defaultMove * (index) + move) /
                    defaultMove +
                _move1;
            double _scaleT4 = defaultScaleR -
                (defaultMove * (index) + move) /
                    defaultMove *
                    (defaultScaleR - defaultScaleR * defaultScaleR);
            _move = _moveT4 > _move2 ? _move2 : _moveT4;
            _scale = _scaleT4 < defaultScaleR * defaultScaleR
                ? defaultScaleR * defaultScaleR
                : _scaleT4;
            _opacity = defaultOpacity;
          }
        } else if (i == index + 2) {
          // 计算当前页的下一张的下一张的移动情况
          double _moveT2 = (_move2 - _move1) *
                  (defaultMove * (index + 1) + move) /
                  defaultMove +
              _move1;
          double _scaleT2 = defaultScaleR -
              (defaultMove * (index + 1) + move) /
                  defaultMove *
                  (defaultScaleR - defaultScaleR * defaultScaleR);

          _move =
              _moveT2 > _move2 ? _move2 : _moveT2 < _move1 ? _move1 : _moveT2;
          _scale = _scaleT2 > defaultScaleR
              ? defaultScaleR
              : _scaleT2 < defaultScaleR * defaultScaleR
                  ? defaultScaleR * defaultScaleR
                  : _scaleT2;
          _opacity = defaultOpacity;
        } else {
          // 之后没有显示的页面的移动情况
          _move = _move2;
          _scale = defaultScaleR * defaultScaleR;
          _opacity = defaultOpacity;
        }
      } else if (i < index) {
        // 计算当前页的前一张的移动情况
        _move = -defaultMove;
        _scale = defaultScaleL;
        _opacity = 0;

        // 如果当前页是返回前一张的话
        if (i == index - 1 && isPrevMove) {
          double _moveT3 = defaultMove * (index - 1) + move;
          double _scaleT3 = 1 -
              (defaultMove * (index - 1) + move) /
                  -defaultMove *
                  (1 - defaultScaleL);
          _move = _moveT3 > 0 ? 0 : _moveT3;
          _scale = _scaleT3 > 1 ? 1 : _scaleT3;
        }
      } else {
        // 判断当前页面的移动情况

        // 如果当前页是返回前一张的话
        if (isPrevMove) {
          // 只有2张图片的情况
          if (arr.length == 2) {
            _move1 = defaultWidth -
                defaultWidth * defaultScaleR +
                screen.setWidth(52);
          }

          double _moveT5 =
              (defaultMove * (index) + move) / defaultMove * _move1;
          double _scaleT5 = 1 -
              (defaultMove * (index) + move) /
                  defaultMove *
                  (1 - defaultScaleR);
          double _opacityT5 =
              (defaultMove * (index) + move) / defaultMove * defaultOpacity;
          _move = _moveT5 > _move1 ? _move1 : _moveT5;
          _scale = _scaleT5 < defaultScaleR ? defaultScaleR : _scaleT5;
          _opacity = _opacityT5 < 0
              ? 0
              : _opacityT5 > defaultOpacity ? defaultOpacity : _opacityT5;
        } else {
          _move = defaultMove * index + move;
          _scale = 1 -
              (defaultMove * index + move) / -defaultMove * (1 - defaultScaleL);
          _opacity = 0;
        }
      }

//      print('$i => $_move => $_scale => $_opacity');

      tiles.add(new Positioned(
          child: new Container(
            width: screen.setWidth(270),
            height: screen.setWidth(370),
            child: new Opacity(
              opacity: _opacity,
              child: new Container(
                color: Colors.white,
              ),
            ),
            transform: Matrix4(
                _scale,
                0,
                0,
                0,
                0,
                _scale,
                0,
                0,
                0,
                0,
                1,
                0,
                _move,
                (screen.setWidth(370) - _scale * screen.setWidth(370)) / 2,
                0,
                1),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(screen.setWidth(12))),
                image: new DecorationImage(
                  image: AssetImage('images/test_move${i + 1}.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: screen.setWidth(8),
                      spreadRadius: screen.setWidth(2))
                ]),
          ),
          top: 0,
          left: screen.setWidth(27)));
    }
    return new GestureDetector(
      onHorizontalDragStart: moveStart,
      onHorizontalDragUpdate: moveUpdate,
      onHorizontalDragEnd: moveEnd,
      child: new Container(
        width: double.infinity,
        height: screen.setWidth(370),
        child: new Stack(children: tiles),
      ),
    );
  }
}



class BookTitle extends StatefulWidget {
  @override
  _BookTitleState createState() => _BookTitleState();
}

class _BookTitleState extends State<BookTitle> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topLeft,
      margin:
          EdgeInsets.fromLTRB(screen.setWidth(27), screen.setWidth(29), 0, 0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: screen.setWidth(10)),
            height: screen.setWidth(20),
            child: new Text(
              '代码整洁之道',
              style: new TextStyle(
                  fontSize: screen.setSp(20),
                  color: const Color(0xff212121),
                  height: 1),
            ),
          ),
          new Container(
            height: screen.setWidth(15),
            child: new Text(
              '[美] Robert Hoekman，Jr.',
              style: new TextStyle(
                  fontSize: screen.setSp(15),
                  color: const Color(0xff939393),
                  height: 1),
            ),
          )
        ],
      ),
    );
  }
}


class IndexTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topRight,
      margin:
          EdgeInsets.fromLTRB(0, 0, screen.setWidth(15), screen.setWidth(14)),
      child: new Text(
        'IT技术',
        style: new TextStyle(
            fontSize: screen.setSp(20),
            color: const Color(0xff50bbd8),
            height: 1),
      ),
    );
  }
}
