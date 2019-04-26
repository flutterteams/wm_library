import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/actions/login.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';

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
          height: screen.setWidth(33),
          child: new IconButton(
              padding: new EdgeInsets.all(screen.setWidth(13)),
              alignment: Alignment.topLeft,
              icon: new Icon(Icons.arrow_back_ios),
              color: const Color(0xffbbbbbb),
              iconSize: screen.setWidth(20),
              onPressed: () {
                Navigator.pop(context);
              }),
          alignment: Alignment.topLeft,
          margin: new EdgeInsets.fromLTRB(0, screen.setWidth(20), 0, 0),
        ),
        new Container(
            width: screen.setWidth(94),
            height: screen.setWidth(24),
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(138), 0, screen.setWidth(46)),
            child: new Image.asset('images/login.png', fit: BoxFit.cover)),
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
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 15.0);

  Animation<double> grayAnimation;
  Animation<double> blueAnimation;
  Animation<double> redAnimation;
  Animation<double> rightAnimation;
  AnimationController grayController;
  AnimationController blueController;
  AnimationController redController;
  AnimationController rightController;

  FocusNode _focusNode = FocusNode();

  Timer timer;

  bool enabled = true;

  @override
  void initState() {
    super.initState();

    double grayMoveWidth = screen.setWidth(329);
    double blueMoveWidthStart = screen.setWidth(40);
    double blueMoveWidthEnd = screen.setWidth(369);

    grayController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    grayAnimation =
        new Tween(begin: 0.0, end: grayMoveWidth).animate(grayController);

    blueController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    blueAnimation = new Tween(begin: -blueMoveWidthStart, end: blueMoveWidthEnd)
        .animate(blueController);

    rightController = new AnimationController(
        duration: new Duration(milliseconds: 400), vsync: this);
    rightAnimation =
        new CurvedAnimation(parent: rightController, curve: Curves.easeIn)
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              Timer _timer = new Timer(new Duration(milliseconds: 500), () {
                _getStore().dispatch(new ChangePwAction(''));
                _getStore().dispatch(new PwErrorAction(null, ''));
                Navigator.of(context).pushNamed('/login-input-pw');
                rightController.reset();
              });
            }
          });

    redController = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    redAnimation = new Tween(begin: 0.0, end: 1.0).animate(redController);

    // 监听焦点获取情况, 开始动画
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        grayController.forward();
      } else {
        if (ModalRoute.of(context).isCurrent &&
            _getStore().state.login.email != null) {
          // 开启等待动画
          blueController.repeat();

          // 设置焦点不可获取
          setState(() {
            enabled = false;
          });

          // 增加计时器, 如果10s内接口没有返回, 那么取消等待动画
          timer = new Timer(new Duration(seconds: 10), () {
            if (!blueController.isCompleted) {
              blueController.stop();
              blueController.reset();
              // 恢复焦点获取
              setState(() {
                enabled = true;
              });
            }
          });

          // 判断格式正确性和数据库是否存在邮箱
          LoginActionCreator.checkEmail(_getStore());
        }
      }
    });
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  /// 监听报错了就启动动画展示
  void _onDidChange(store) {
    if (ModalRoute.of(context).isCurrent &&
        store.state.login.emailError != null) {
      blueController.stop();
      blueController.reset();
      // 恢复焦点获取
      setState(() {
        enabled = true;
      });
      timer.cancel();

      if (store.state.login.emailError) {
        if (redController.isCompleted) {
          redController.reset();
          redController.forward();
        } else {
          redController.forward();
        }
      } else {
        rightController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new AnimatedBuilder(
          animation: redAnimation,
          builder: (context, child) {
            return new Container(
              transform: new Matrix4.translationValues(
                  redAnimation.value < 0.25
                      ? redAnimation.value * screen.setWidth(40)
                      : redAnimation.value < 0.5
                          ? (0.5 - redAnimation.value) * screen.setWidth(40)
                          : redAnimation.value < 0.75
                              ? (0.5 - redAnimation.value) * screen.setWidth(40)
                              : (redAnimation.value - 1) * screen.setWidth(40),
                  0,
                  0),
              child: new Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  new Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      new Container(
                        constraints:
                            new BoxConstraints(maxWidth: screen.setWidth(270)),
                        child: new TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          enabled: enabled,
                          cursorColor: Colors.white,
                          style: new TextStyle(
                              fontSize: screen.setSp(18),
                              color: Colors.white,
                              height: 1),
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  screen.setWidth(0), 0, screen.setWidth(0), 0),
                              hintText: '请输入你的邮箱',
                              hintStyle: new TextStyle(
                                  fontSize: screen.setSp(18),
                                  color: const Color(0xff646464),
                                  height: 1),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          focusNode: _focusNode,
                          onChanged: (str) =>
                              LoginActionCreator.changeEmail(store, str),
                        ),
                      ),
                      new AnimatedBuilder(
                          animation: rightAnimation,
                          builder: (context, child) {
                            return new Positioned(
                              child: new Container(
                                width: screen.setWidth(16),
                                child: new CustomPaint(
                                  painter: new MyPainter(
                                      _sizeTween.evaluate(rightAnimation)),
                                ),
                              ),
                              top: screen.setWidth(14),
                              right: screen.setWidth(-25),
                            );
                          })
                    ],
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
                                      : store.state.login.emailError != null &&
                                              store.state.login.emailError
                                          ? Color(0xffDD412A)
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
                                    margin: new EdgeInsets.only(
                                        top: screen.setWidth(0)),
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
                  new Container(
                    margin: new EdgeInsets.only(top: screen.setWidth(44)),
                    child: new Text(
                      store.state.login.emailError != null &&
                              store.state.login.emailError
                          ? store.state.login.emailErrorStr
                          : '',
                      style: new TextStyle(
                        fontSize: screen.setSp(12),
                        color: Color(0xffdd412a),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }, onDidChange: (store) {
      _onDidChange(store);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    grayController.dispose();
    blueController.dispose();
    rightController.dispose();
    redController.dispose();
    super.dispose();
  }
}

/// 画对勾
class MyPainter extends CustomPainter {
  final double _move;

  MyPainter(this._move);

  Paint _paint = Paint()
    ..color = Color(0xff50BBD8) //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
//    Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: screen.setWidth(14));
//    Rect rect2 = Rect.fromCircle(center: Offset(0, 0), radius: screen.setWidth(14));
//    Rect rect3 = Rect.fromCircle(center: Offset(-screen.setWidth(28), -screen.setWidth(21)), radius: screen.setWidth(60));

//    Rect rect =
//        Rect.fromCircle(center: Offset(-80, 0), radius: screen.setWidth(80));
//    Rect rect2 =
//        Rect.fromCircle(center: Offset(20, -28), radius: screen.setWidth(14));
//    Rect rect3 =
//        Rect.fromCircle(center: Offset(40, -70), radius: screen.setWidth(60));
//
//    Path path = new Path();
//    path.moveTo(40, 0);
//
//    canvas.drawPath(path, _paint);

    if (_move == 0) {
      return;
    }
    if (_move < 5) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(_move, _move), _paint);
    } else {
      canvas.drawLine(Offset(0.0, 0.0), Offset(5.0, 5.0), _paint);
      canvas.drawLine(Offset(5.0, 5.0), Offset(_move, 10 - _move), _paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return _move != oldDelegate._move;
  }
}
