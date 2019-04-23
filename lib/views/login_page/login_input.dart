import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    double w = screen.setWidth(329);

    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 0.0, end: w).animate(controller)
      ..addStatusListener((state) => print(state));

    // 监听获取焦点, 开始动画
    _focusNode.addListener(() {
      print(_focusNode.hasFocus);
      if (_focusNode.hasFocus) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
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
            focusNode: _focusNode
        ),
        new AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return new Container(
                margin: new EdgeInsets.only(top: screen.setWidth(15)),
                width: screen.setWidth(329),
                height: screen.setWidth(1),
                alignment: Alignment.topLeft,
                child: new Container(
                  width: animation.value,
                  height: screen.setWidth(1),
                  color: const Color(0xff5c5c5c),
                ),
              );
            })
      ],
    );
  }
}
