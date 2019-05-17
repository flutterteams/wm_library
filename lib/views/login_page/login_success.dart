import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/actions/login.dart';
import 'package:wm_library/components/scroll_bg/scroll_bg.dart';

class LoginSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new LoginSuccessHome(), 'opacity'),
    );
  }
}

class LoginSuccessHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
            width: screen.setWidth(94),
            height: screen.setWidth(24),
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(190), 0, screen.setWidth(40)),
            child: new Image.asset('images/login.png', fit: BoxFit.cover)),
        new LoginDetailSuccess()
      ],
    );
  }
}

class LoginDetailSuccess extends StatefulWidget {
  @override
  _LoginDetailSuccessState createState() => _LoginDetailSuccessState();
}

class _LoginDetailSuccessState extends State<LoginDetailSuccess>
    with TickerProviderStateMixin {
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 34.0);

  Animation<double> circleAnimation;
  Animation<double> rightAnimation;
  AnimationController circleController;
  AnimationController rightController;


  @override
  void initState() {
    super.initState();

    circleController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    circleAnimation =
        new Tween(begin: 0.0, end: math.pi*2).animate(circleController)..addStatusListener((state) {
          if (state == AnimationStatus.completed){
            rightController.forward();
          }
        });

    rightController = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this);
    rightAnimation =
        new CurvedAnimation(parent: rightController, curve: Curves.easeIn)
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              Timer _timer = new Timer(new Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed('/index');
              });
            }
          });

    circleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: screen.setWidth(80),
      height: screen.setWidth(80),
      child: new Stack(
        children: <Widget>[
          new AnimatedBuilder(animation: circleAnimation, builder: (context, child){
            return new Container(
              child: new CustomPaint(
                painter: new MyPainter(circleAnimation.value),
              ),
            );
          }),
          new Positioned(child: new AnimatedBuilder(animation: rightAnimation, builder: (context, child) {
            return new Container(
              width: screen.setWidth(37),
              height: screen.setWidth(25),
              child: new CustomPaint(
                painter: new MyPainter2(_sizeTween.evaluate(rightAnimation)),
              ),
            );
          }), left: screen.setWidth(23),
          top: screen.setWidth(41),)
        ],
      ),
    );
  }

  dispose() {
    circleController.dispose();
    rightController.dispose();
    super.dispose();
  }
}

/// 画圆
class MyPainter extends CustomPainter {
  final double _angle;

  MyPainter(this._angle);

  Paint _paint = Paint()
    ..color = Color(0xff50BBD8) //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(center: Offset(40.0, 40.0), radius: 40.0);
    canvas.drawArc(rect, -math.pi/2, _angle, false, _paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return _angle != oldDelegate._angle;
  }
}


/// 画对勾
class MyPainter2 extends CustomPainter {
  final double _move;

  MyPainter2(this._move);

  Paint _paint = Paint()
    ..color = Color(0xff50BBD8) //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {

    if (_move == 0) {
      return;
    }
    if (_move < 14) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(_move, _move*6/7), _paint);
    } else {
      canvas.drawLine(Offset(0.0, 0.0), Offset(14.0, 12.0), _paint);
      canvas.drawLine(Offset(14.0, 12.0), Offset(_move, 26-_move), _paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter2 oldDelegate) {
    return _move != oldDelegate._move;
  }
}