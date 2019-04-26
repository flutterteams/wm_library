import 'dart:async';

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
        store.dispatch(new EmailErrorAction(null));
      }
    }
  }

  /// 判断输入email
  static checkEmail(store) {
    String str = store.state.login.email;
    Timer timer = new Timer(new Duration(seconds: 2), () {
      if (str.length > 16 && str.endsWith('@frogshealth.com')) {
        store.dispatch(new EmailErrorAction(false));
      } else {
        store.dispatch(new EmailErrorAction(true));
      }
    });
  }

  /// 输入pw监听方法
  static changePw(store, value) {
    if (store.state.login.pw != value) {
      store.dispatch(new ChangePwAction(value));
      if (store.state.login.pwError != null &&
          store.state.login.pwError) {
        store.dispatch(new PwErrorAction(null));
      }
    }
  }

  /// 判断输入pw
  static checkPw(store) {
    String str = store.state.login.pw;
    Timer timer = new Timer(new Duration(seconds: 2), () {
      if (str.length > 5) {
        store.dispatch(new PwErrorAction(false));
      } else {
        store.dispatch(new PwErrorAction(true));
      }
    });
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

  EmailErrorAction(this.emailError);
}


/// pw输入action
class ChangePwAction {
  final String pw;

  ChangePwAction(this.pw);
}

/// pw报错
class PwErrorAction {
  final bool pwError;

  PwErrorAction(this.pwError);
}
