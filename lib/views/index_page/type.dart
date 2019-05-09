import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/actions/index.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

class TypeHero extends StatelessWidget {
  const TypeHero({Key key, this.tag, this.color}) : super(key: key);

  final String tag;
  final Color color;

  Widget build(BuildContext context) {
    return new Hero(
      tag: tag,
      child: new Material(
        color: Colors.transparent,
        child: new Container(
          height: screen.setWidth(2),
          width: screen.setWidth(22),
          color: color,
        ),
      ),
    );
  }
}

class TypePage extends StatefulWidget {
  Store store;

  TypePage(this.store);

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> with TickerProviderStateMixin {
  List<Widget> tiles = [];

  Animation<double> animation1;
  Animation<double> animation2;
  AnimationController controller;
  AnimationController controller1;
  AnimationController controller2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    controller1 = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation1 =
        new Tween(begin: 0.0, end: math.pi / 4 * 3).animate(controller1);
    controller2 = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation2 =
        new Tween(begin: 0.0, end: math.pi / 4 * 5).animate(controller2);

    Timer timer2 = new Timer(Duration(milliseconds: 200), () {
      controller1.forward();
      controller2.forward();
    });

    Timer timer = new Timer(Duration(milliseconds: 300), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller.dispose();
  }

  void onClose() {
      controller1.reverse();
      controller2.reverse();
      Timer timer = new Timer(Duration(milliseconds: 300), () {
        Navigator.of(context).pop();
      });
  }

  @override
  Widget build(BuildContext context) {
    List list = widget.store.state.index.typeList;

    for (int i = 0; i < list.length; i++) {
      tiles.add(new FadeTransition(
        opacity: new Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(1.0 / list.length * i - 0.2 / list.length * i,
                1.0 / list.length * (i + 1)))),
        child: new GestureDetector(
          onTap: () {
            IndexActionCreator.changeId(widget.store, i);
            onClose();
          },
          child: new Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(32)),
            child: new Text(
              list[i]['name'] == 'IT技术' ? 'I T  技术' : list[i]['name'],
              style: new TextStyle(
                fontSize: screen.setSp(20),
                color: Color.fromRGBO(255, 255, 255, 0.8),
                letterSpacing: list[i]['name'].length == 2
                    ? screen.setWidth(48)
                    : list[i]['name'].length == 3
                        ? screen.setWidth(14)
                        : list[i]['name'] == 'IT技术'
                            ? screen.setWidth(1.6)
                            : screen.setWidth(2),
              ),
            ),
          ),
        ),
      ));
    }

    return new Scaffold(
      body: new Container(
          color: Colors.black,
          child: new Stack(
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(top: screen.setWidth(144)),
                  child: new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: tiles,
                    ),
                  )),
              new Positioned(
                  top: screen.setWidth(28),
                  child: new GestureDetector(
                    onTap: onClose,
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(
                          screen.setWidth(13), screen.setWidth(20), 0, 0),
                      color: Colors.transparent,
                      height: screen.setWidth(50),
                      child: new Column(
                        children: <Widget>[
                          new AnimatedBuilder(
                              animation: animation1,
                              builder: (context, child) {
                                return new Transform.rotate(
                                  angle: animation1.value,
                                  child: new TypeHero(
                                    tag: 'type1',
                                    color: Colors.white,
                                  ),
                                );
                              }),
                          new Container(
                            transform: Matrix4.translationValues(
                                0, screen.setWidth(-1), 0),
                            child: new AnimatedBuilder(
                                animation: animation2,
                                builder: (context, child) {
                                  return new Transform.rotate(
                                    angle: animation2.value,
                                    child: new TypeHero(
                                      tag: 'type2',
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
