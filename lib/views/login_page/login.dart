import 'package:flutter/material.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';
import 'package:wm_library/common/global_variable.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ScrollBg(new LoginHome(), 'gradient'),
    );
  }
}

/// 半透明背景色
class LoginBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new LoginHome(),
      decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: [
        Color.fromRGBO(0, 0, 0, 0.75),
        Color.fromRGBO(0, 0, 0, 1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    );
  }
}

/// 主要内容
class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(
              0, screen.setWidth(253), 0, screen.setWidth(24)),
          child: new Image.asset(
            'images/frog_share.png',
            fit: BoxFit.cover,
            width: screen.setWidth(232),
            height: screen.setWidth(26),
          ),
        ),
        new Text(
          '记录脚步，分享感悟',
          style: new TextStyle(
              fontSize: screen.setSp(18),
              color: const Color(0xff999999),
              letterSpacing: screen.setWidth(4),
              height: 1.1),
        ),
        new Container(
          margin: new EdgeInsets.fromLTRB(
              0, screen.setWidth(139), 0, screen.setWidth(16)),
          child: new FlatButton(
            onPressed: () {
              print('登录');
              Navigator.of(context).pushNamed('/login-input');
            },
            child: new Text(
              '登录',
              style: new TextStyle(
                  fontSize: screen.setSp(16),
                  color: const Color(0xff141414),
                  letterSpacing: screen.setWidth(2),
                  height: 1,
                  fontWeight: FontWeight.normal),
            ),
            color: Colors.white,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(
                screen.setWidth(133),
                screen.setWidth(12),
                screen.setWidth(133),
                screen.setWidth(12)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(screen.setWidth(22)))),
          ),
        ),
        new Opacity(
          opacity: 0.8,
          child: new OutlineButton(
            onPressed: () {
              print('注册');
              Navigator.of(context).pushNamed('/register');
            },
            child: new Text(
              '注册',
              style: new TextStyle(
                  fontSize: screen.setSp(16),
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  letterSpacing: screen.setWidth(2),
                  height: 1,
                  fontWeight: FontWeight.normal),
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(
                screen.setWidth(132),
                screen.setWidth(11),
                screen.setWidth(132),
                screen.setWidth(11)),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
            highlightedBorderColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(screen.setWidth(22)))),
          ),
        )
      ],
    );
  }
}
