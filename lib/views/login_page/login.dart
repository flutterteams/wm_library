import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/actions/login.dart';
import 'package:wm_library/actions/password.dart';
import 'package:wm_library/actions/register.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';

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
    Store<AppState> _getStore() {
      return StoreProvider.of(context);
    }

    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(
              0, screen.setHeight(253), 0, screen.setHeight(14)),
          child: new Image.asset(
            'images/frog_share.png',
            fit: BoxFit.cover,
//            width: screen.setWidth(232),
//            height: screen.setWidth(26),
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
              0, screen.setHeight(139), 0, screen.setHeight(16)),
          child: new FlatButton(
            onPressed: () {
              print('登录');
              _getStore().dispatch(new ChangesEmailAction(''));
              _getStore().dispatch(new ChangesPwAction(''));
              _getStore().dispatch(new EmailsErrorAction(null, ''));
              _getStore().dispatch(new PwsErrorAction(null, ''));
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
              _getStore().dispatch(new ChangeNameAction(''));
              _getStore().dispatch(new ChangePhoneAction(''));
              _getStore().dispatch(new ChangeEmailAction(''));
              _getStore().dispatch(new ChangePositionAction(''));
              _getStore().dispatch(new ChangeCompanyIdAction(''));

              _getStore().dispatch(new NameErrorAction(null));
              _getStore().dispatch(new PhoneErrorAction(null));
              _getStore().dispatch(new EmailErrorAction(null));
              _getStore().dispatch(new PositionErrorAction(null));
              _getStore().dispatch(new CompanyErrorAction(null));
              _getStore().dispatch(new IsRegisterAction(null));

              _getStore().dispatch(new ChangePassWordAction(''));
              _getStore().dispatch(new ChangeConfirmPwdAction(''));
              _getStore().dispatch(new PwdErrorAction(null));
              _getStore().dispatch(new ConfirmPwdErrorAction(null));
              _getStore().dispatch(new IsSuccessAction(null));

              Navigator.of(context).pushNamed('/register');
              //Navigator.of(context).pushNamed('/personal');
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
