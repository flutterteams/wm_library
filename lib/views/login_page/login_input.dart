import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/actions/login.dart';
import 'package:wm_library/reducers/login_reducer.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';

final screen = ScreenUtil.getInstance();

class LoginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new LoginInputHome(), 'opacity'),
    );
  }
}

class LoginInputHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(170), 0, screen.setWidth(45)),
            child: new Image.asset('images/testlogin.png', fit: BoxFit.cover)),
        new LoginDetailInput()
      ],
    );
  }
}

class LoginDetailInput extends StatefulWidget {
  @override
  _LoginDetailInputState createState() => _LoginDetailInputState();
}

class _LoginDetailInputState extends State<LoginDetailInput>
    with TickerProviderStateMixin {
  Animation<double> grayAnimation;
  Animation<double> blueAnimation;
  Animation<double> percentageAnimation;
  AnimationController grayController;
  AnimationController blueController;
  AnimationController percentageController;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    double grayMoveWidth = screen.setWidth(329);
    double blueMoveWidthStart = screen.setWidth(40);
    double blueMoveWidthEnd = screen.setWidth(369);

    grayController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    grayAnimation = new Tween(begin: 0.0, end: grayMoveWidth)
        .animate(grayController)
          ..addStatusListener((state) => print(state));

    blueController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    blueAnimation = new Tween(begin: -blueMoveWidthStart, end: blueMoveWidthEnd)
        .animate(blueController)
          ..addStatusListener((state) => print(state));

    percentageController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    percentageAnimation = new Tween(begin: math.pi*2, end: 0.0)
        .animate(percentageController)
          ..addStatusListener((state) => print(state));

    // 监听焦点获取情况, 开始动画
    _focusNode.addListener(() {
      print(_focusNode.hasFocus);
      if (_focusNode.hasFocus) {
        grayController.forward();
        percentageController.forward();
      } else {
        if (_getStore().state.login.email != null) {
          blueController.repeat();
          Timer timer = new Timer(new Duration(seconds: 2), () {
            blueController.stop();
          });
        }
      }
    });

  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          new TextField(
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: screen.setSp(18), color: Colors.white, height: 1),
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: '请输入你的邮箱',
                hintStyle: new TextStyle(
                    fontSize: screen.setSp(18),
                    color: const Color(0xff646464),
                    height: 1),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
            focusNode: _focusNode,
            onChanged: (str) => LoginActionCreator.changeEmail(store, str),
          ),
          new Container(
            margin: new EdgeInsets.only(top: screen.setWidth(33)),
            alignment: Alignment.topLeft,
            width: screen.setWidth(329),
            height: screen.setWidth(2),
            child: new Stack(
              children: <Widget>[
                new AnimatedBuilder(
                    animation: grayAnimation,
                    builder: (context, child) {
                      return new Positioned(
                        child: new Container(
                          width: grayAnimation.value,
                          height: screen.setWidth(1),
                          color: store.state.login.email == null
                              ? Color(0xff5c5c5c)
                              : Color(0xffaeaeae),
                        ),
                        top: 0,
                        left: 0,
                      );
                    }),
                new AnimatedBuilder(
                    animation: blueAnimation,
                    builder: (context, child) {
                      return new Positioned(
                        child: new Container(
                            margin:
                                new EdgeInsets.only(top: screen.setWidth(1)),
                            width: screen.setWidth(40),
                            height: screen.setWidth(2),
                            color: Color(0xff50bbd8)),
                        left: blueAnimation.value,
                        top: -0.5,
                      );
                    }),
              ],
            ),
          ),
          new AnimatedBuilder(
              animation: percentageAnimation,
              builder: (context, child) {
                return new Positioned(
                  child: new CustomPaint(
                    painter: new MyPainter(percentageAnimation.value),
                  ),
//                  top: screen.setWidth(10),
                bottom: 0,
                  right: screen.setWidth(50),
                );
              })
        ],
      );
    });
  }

  dispose() {
    grayController.dispose();
    blueController.dispose();
    percentageController.dispose();
    super.dispose();
  }
}

/// 画圆
class MyPainter extends CustomPainter {
  final double _radius;

  MyPainter(this._radius);

  Paint _paint = Paint()
    ..color = Color(0xff50BBD8) //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0; //画笔的宽度

  Paint _paint2 = Paint()
    ..color = Colors.red //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 2.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {

//    Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: screen.setWidth(14));
//    Rect rect2 = Rect.fromCircle(center: Offset(0, 0), radius: screen.setWidth(14));
//    Rect rect3 = Rect.fromCircle(center: Offset(-screen.setWidth(28), -screen.setWidth(21)), radius: screen.setWidth(60));

    Rect rect = Rect.fromCircle(center: Offset(-80, 0), radius: screen.setWidth(80));
    Rect rect2 = Rect.fromCircle(center: Offset(20, -28), radius: screen.setWidth(14));
    Rect rect3 = Rect.fromCircle(center: Offset(40, -70), radius: screen.setWidth(60));

  Path path = new Path();
  path.moveTo(40, 0);
    path.cubicTo(40, 0, 24, -1, 9, -19);
//  path.arcTo(rect, 0.0, 3.14*0.5, false);
  path.arcTo(rect2, 3.14*0.8, 3.14*1.4, false);
//  path.arcTo(rect3, 3.14*1.6, 3.14*0.3, false);
    path.cubicTo(31, -18, 16, -1,0,0 );

  canvas.drawPath(path, _paint);
//    canvas.drawArc(rect, 0.0, math.pi*2, false, _paint);
//    canvas.drawArc(rect2, math.pi, _radius, false, _paint2);
//    canvas.drawArc(rect3, 0.0, math.pi/4, false, _paint);

  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return _radius != oldDelegate._radius;
  }
}
