import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/actions/index.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/views/index_page/type.dart';
import 'package:wm_library/views/detail_page/detail.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new IndexHome(),
    );
  }
}

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    IndexActionCreator.getTypeList(_getStore());
    IndexActionCreator.getList(_getStore());
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Column(
                  children: <Widget>[
                    new IndexTop(store),
                    new IndexMain(store),
                  ],
                ),
              ),
              new IndexTo(store)
            ],
          ),
        ],
      );
    });
  }
}

/// 顶部导航
class IndexTop extends StatefulWidget {
  Store store;

  IndexTop(this.store);

  @override
  _IndexTopState createState() => _IndexTopState();
}

class _IndexTopState extends State<IndexTop> with TickerProviderStateMixin {
  Animation<double> animation1;
  AnimationController controller1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1 = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation1 = new Tween(begin: 0.0, end: 1.0).animate(controller1);
  }

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          screen.setWidth(13), screen.setWidth(34), screen.setWidth(13), 0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new GestureDetector(
            child: new Container(
              color: Colors.transparent,
              width: screen.setWidth(22),
              height: screen.setWidth(23),
              child: new Column(children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                      0, screen.setWidth(9), 0, screen.setWidth(10)),
                  child: new TypeHero(
                    tag: 'type1',
                    color: const Color(0xff424242),
                  ),
                ),
                new TypeHero(
                  tag: 'type2',
                  color: const Color(0xff424242),
                )
              ]),
            ),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return new TypePage(widget.store);
                    },
                    transitionsBuilder: (context, Animation<double> animation,
                        Animation<double> secondaryAnimation, child) {
                      return new SlideTransition(
                        position:
                            new Tween(begin: Offset(0, -1.0), end: Offset(0, 0))
                                .animate(animation),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300)),
              );
            },
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
  Store store;
  String name;

  IndexTitle(this.store, this.name);

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
      child: widget.store.state.index.id == 0
          ? new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  height: screen.setWidth(30),
                  margin: new EdgeInsets.fromLTRB(
                      0, screen.setWidth(15), 0, screen.setWidth(14)),
                  child: new Text(
                    widget.store.state.index.typeList.length == 0
                        ? ''
                        : widget.store.state.index
                            .typeList[widget.store.state.index.id]['name'],
                    style: new TextStyle(
                        color: const Color(0xff212121),
                        fontSize: screen.setSp(30),
                        height: 1,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                new Container(
                  height: screen.setWidth(24),
                  child: new Text(widget.name,
                      style: new TextStyle(
                        color: const Color(0xff424242),
                        fontSize: screen.setSp(24),
                        height: 1,
                      )),
                )
              ],
            )
          : new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  height: screen.setWidth(30),
                  margin: new EdgeInsets.fromLTRB(
                      0, screen.setWidth(27), 0, screen.setWidth(12)),
                  child: new Text(
                    widget.store.state.index.typeList.length == 0
                        ? ''
                        : widget.store.state.index
                            .typeList[widget.store.state.index.id]['name'],
                    style: new TextStyle(
                        color: const Color(0xff212121),
                        fontSize: screen.setSp(30),
                        height: 1,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
    );
  }
}

class IndexMain extends StatefulWidget {
  Store store;

  IndexMain(this.store);

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

  Animation<double> animation;
  AnimationController controller;

  List arr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addStatusListener((status) {
        // 判断动画完成之后, 应该重置的值
        if (status == AnimationStatus.completed) {
          if (moveX - startX < -screen.setWidth(375) / 5 &&
              index < arr.length - 1) {
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
          controller.reset();
        }
      });
  }

  void moveStart(e) {
    startX = e.globalPosition.dx;
    startY = e.globalPosition.dy;
  }

  void moveUpdate(e) {
    double _moveT = 0;

    moveX = e.globalPosition.dx;
    moveY = e.globalPosition.dy;

    if ((moveX - startX).abs() > (moveY - startY).abs()) {
//      print('水平');
      if (moveX - startX > 0) {
//        print('向右移动');
        isPrevMove = true;
        if (index == 0) {
          return;
        }
      } else {
//        print('向左移动');
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
//      print('垂直');
    }
  }

  void moveEnd(e) {
    // 判断手指离开, 是否移动

    // 动画没有执行完毕, 页面禁止移动
    if (controller.isAnimating) {
      return;
    }

    // 计算应该开始什么动画
    if (moveX - startX < -screen.setWidth(375) / 5 && index < arr.length - 1) {
      animation = new Tween(begin: move, end: -defaultMove * (index + 1))
          .animate(controller);
    } else if (moveX - startX > screen.setWidth(375) / 5 && index > 0) {
      animation = new Tween(begin: move, end: -defaultMove * (index - 1))
          .animate(controller);
    } else {
      animation =
          new Tween(begin: move, end: -defaultMove * index).animate(controller);
    }

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arr = widget.store.state.index.list;
    List typeList = widget.store.state.index.typeList;
    String name = '';

    // 计算上面推荐子标题显示内容
    for (int i = 0; i < typeList.length; i++) {
      if (arr.length > 0 &&
          arr[index.toInt()]['type_id'] == typeList[i]['id']) {
        name = typeList[i]['name'];
      }
    }

    return new AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return new Column(
            children: <Widget>[
              new IndexTitle(widget.store, name),
              new GestureDetector(
                onHorizontalDragStart: moveStart,
                onHorizontalDragUpdate: moveUpdate,
                onHorizontalDragEnd: moveEnd,
                child: new Container(
                  width: double.infinity,
                  height: screen.setWidth(370),
                  child: new MoveCard(
                      arr,
                      controller.isAnimating ? animation.value : move,
                      index,
                      isPrevMove,
                      defaultMove),
                ),
              ),
              new BookTitle(
                  arr,
                  controller.isAnimating ? animation.value : move,
                  index,
                  defaultMove)
            ],
          );
        });
  }
}

class MoveCard extends StatelessWidget {
  List arr;
  double move; // 每一次的移动距离的叠加
  double index; // 当前展示的图片序号
  bool isPrevMove; // 是否是返回前一张
  double defaultMove; // 默认图片移动到页面外的移动距离

  MoveCard(this.arr, this.move, this.index, this.isPrevMove, this.defaultMove);

  double defaultScaleL = 0.7; // 默认图片移动到页面外缩放的比例
  double defaultScaleR = 0.8; // 默认首张图片下面的图片的缩放比例
  double defaultOpacity = 0.4; // 默认透明度

  double defaultWidth = screen.setWidth(270); // 初始化图片宽度
  double defaultHeight = screen.setWidth(370); // 初始化图片高度

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
          child: new GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Detail(arr[i]['id']),
                ),
              );
            },
            child: new Container(
              width: screen.setWidth(270),
              height: screen.setWidth(370),
              child: new Opacity(
                opacity: _opacity,
                child: new Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(screen.setWidth(12))),
                      color: Colors.white,
                    )),
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
                    image: NetworkImage(arr[i]['url'] == null
                        ? 'https://gd1.alicdn.com/imgextra/i1/2418395878/TB2G1jFFHGYBuNjy0FoXXciBFXa_!!2418395878.jpg'
                        : arr[i]['url']),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: i < index + 3 ||
                      (i == index + 3 && move + defaultMove * index < 0)
                      ? [
                    BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: screen.setWidth(8),
                        spreadRadius: screen.setWidth(2))
                  ]
                      : []),
            ),
          ),
          top: 0,
          left: screen.setWidth(27)));
    }
    return new Stack(children: tiles);
  }
}

class BookTitle extends StatelessWidget {
  List arr;
  double index;
  double move;
  double defaultMove;

  BookTitle(this.arr, this.move, this.index, this.defaultMove);

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    for (int i = arr.length - 1; i >= 0; i--) {
      tiles.add(new Positioned(
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: screen.setWidth(321),
                  alignment: Alignment.topLeft,
                  height: screen.setWidth(24),
                  margin: EdgeInsets.only(bottom: screen.setWidth(6)),
                  child: new Text(
                    arr[i]['title'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: new TextStyle(
                      fontSize: screen.setSp(20),
                      color: const Color(0xff212121),
                    ),
                  ),
                ),
                new Container(
                  alignment: Alignment.bottomLeft,
                  child: new Text(
                    arr[i]['author'],
                    style: new TextStyle(
                        fontSize: screen.setSp(15),
                        color: const Color(0xff939393),
                        height: 1),
                  ),
                )
              ],
            ),
          ),
          top: screen.setWidth(70) * i +
              move / defaultMove * screen.setWidth(70)));
    }

    return new Container(
        height: screen.setWidth(50),
        alignment: Alignment.topLeft,
        margin:
            EdgeInsets.fromLTRB(screen.setWidth(27), screen.setWidth(23), 0, 0),
        child: new Stack(
          overflow: Overflow.clip,
          alignment: Alignment.topLeft,
          children: tiles,
        ));
  }
}

class IndexTo extends StatelessWidget {
  Store store;

  IndexTo(this.store);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new GestureDetector(
          child: new Container(
            margin: EdgeInsets.fromLTRB(
                screen.setWidth(15), 0, 0, screen.setWidth(14)),
            child: new Text(
              store.state.index.id == 0
                  ? ''
                  : store.state.index.typeList[store.state.index.id - 1]
                      ['name'],
              style: new TextStyle(
                  fontSize: screen.setSp(20),
                  color: const Color(0xff50bbd8),
                  height: 1),
            ),
          ),
          onTap: () {
            IndexActionCreator.changeId(store, store.state.index.id - 1);
            Navigator.of(context).pop();
          },
        ),
        new GestureDetector(
          child: new Container(
            margin: EdgeInsets.fromLTRB(
                0, 0, screen.setWidth(15), screen.setWidth(14)),
            child: new Text(
              store.state.index.typeList.length == 0
                  ? ''
                  : store.state.index.id ==
                          store.state.index.typeList.length - 1
                      ? ''
                      : store.state.index.typeList[store.state.index.id + 1]
                          ['name'],
              style: new TextStyle(
                  fontSize: screen.setSp(20),
                  color: const Color(0xff50bbd8),
                  height: 1),
            ),
          ),
          onTap: () {
            IndexActionCreator.changeId(store, store.state.index.id + 1);
            Navigator.of(context).pushNamed('/index');
          },
        )
      ],
    );
  }
}
