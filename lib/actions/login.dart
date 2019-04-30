import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/common/dao.dart';

class LoginActionCreator {
  static login(store) {
    Dao.noTokenPost('/api/admin/login', {"name": 'admin', "password": 'bjfrog'},
        (data) => {print(data)}, (data) => {print(data)});
  }

  /// 输入email监听方法
  static changeEmail(store, value) {
    if (store.state.login.email != value) {
      store.dispatch(new ChangeEmailAction(value));
      if (store.state.login.emailError != null &&
          store.state.login.emailError) {
        store.dispatch(new EmailErrorAction(null, ''));
      }
    }
  }

  /// 判断输入email
  static checkEmail(store) {
    String _str = store.state.login.email;

    if (_str.length > 16 && _str.endsWith('@frogshealth.com')) {

      Timer timer2 = new Timer(new Duration(seconds: 2), () {
        store.dispatch(new EmailErrorAction(false, ''));
      });

//      DateTime _now1 = new DateTime.now();
//
//      Dao.noTokenPost('/api/user/emailCheck', {'email': _str}, (data) {
//        DateTime _now2 = new DateTime.now();
//        var _time = _now2.millisecondsSinceEpoch - _now1.millisecondsSinceEpoch;
//
//        // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
//        if (_time < 2000) {
//          Timer timer = new Timer(new Duration(milliseconds: 2000 - _time), () {
//            store.dispatch(new EmailErrorAction(false, ''));
//          });
//        } else {
//          store.dispatch(new EmailErrorAction(false, ''));
//        }
//      }, (data) {
//        DateTime _now2 = new DateTime.now();
//        var _time = _now2.millisecondsSinceEpoch - _now1.millisecondsSinceEpoch;
//
//        // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
//        if (_time < 2000) {
//          Timer timer = new Timer(new Duration(milliseconds: 2000 - _time), () {
//            store.dispatch(new EmailErrorAction(true, '该邮箱未注册'));
//          });
//        } else {
//          store.dispatch(new EmailErrorAction(true, '该邮箱未注册'));
//        }
//      });
    } else {
      // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
      Timer timer2 = new Timer(new Duration(seconds: 2), () {
        store.dispatch(new EmailErrorAction(true, '请输入正确的邮箱'));
      });
    }
  }

  /// 输入pw监听方法
  static changePw(store, value) {
    if (store.state.login.pw != value) {
      store.dispatch(new ChangePwAction(value));
      if (store.state.login.pwError != null && store.state.login.pwError) {
        store.dispatch(new PwErrorAction(null, ''));
      }
    }
  }

  /// 判断输入pw
  static checkPw(store) {
    String _email = store.state.login.email;
    String _str = store.state.login.pw;
    SharedPreferences sharedPreferences;

    if (_str.length > 5) {

      Timer timer2 = new Timer(new Duration(seconds: 2), () {
        store.dispatch(new PwErrorAction(false, ''));
      });


//      DateTime _now1 = new DateTime.now();
//
//      Dao.noTokenPost('/api/user/login', {'email': _email, 'password': _str},
//          (data) async {
//        print(data);
//        DateTime _now2 = new DateTime.now();
//        var _time = _now2.millisecondsSinceEpoch - _now1.millisecondsSinceEpoch;
//
//        //数据保存到本地
//        sharedPreferences = await SharedPreferences.getInstance();
//        sharedPreferences.setString("name", data['data']['name']);
//        sharedPreferences.setString("token", data['data']['token']);
//
//        // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
//        if (_time < 2000) {
//          Timer timer = new Timer(new Duration(milliseconds: 2000 - _time), () {
//            store.dispatch(new PwErrorAction(false, ''));
//          });
//        } else {
//          store.dispatch(new PwErrorAction(false, ''));
//        }
//      }, (data) {
//        DateTime _now2 = new DateTime.now();
//        var _time = _now2.millisecondsSinceEpoch - _now1.millisecondsSinceEpoch;
//
//        // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
//        if (_time < 2000) {
//          Timer timer = new Timer(new Duration(milliseconds: 2000 - _time), () {
//            store.dispatch(new PwErrorAction(true, '密码输入错误'));
//          });
//        } else {
//          store.dispatch(new PwErrorAction(true, '密码输入错误'));
//        }
//      });
    } else {
      // 设置计时器, 如果2s内接口没有返回, 那么等待, 如果接口返回, 那么动画至少执行2s
      Timer timer2 = new Timer(new Duration(seconds: 2), () {
        store.dispatch(new PwErrorAction(true, '密码输入错误'));
      });
    }
  }
}

/// email输入action
class ChangeEmailAction {
  final String email;

  ChangeEmailAction(this.email);
}

/// email报错
class EmailErrorAction {
  final bool emailError;
  final String emailErrorStr;

  EmailErrorAction(this.emailError, this.emailErrorStr);
}

/// pw输入action
class ChangePwAction {
  final String pw;

  ChangePwAction(this.pw);
}

/// pw报错
class PwErrorAction {
  final bool pwError;
  final String pwErrorStr;

  PwErrorAction(this.pwError, this.pwErrorStr);
}
