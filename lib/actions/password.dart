import 'dart:async';

import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/register/password.dart';
import 'package:wm_library/redux/app_reducer.dart';

class SetPassWordActionCreator {
  static setPassWord(Store<AppState> store) {
    print(store.state.setPwd.password);
//    store.dispatch(new GetPassWordAction(new PassWord(store.state.setPwd.password,
//        store.state.setPwd.confirmPassword)));

    Response response;
    Dao.noTokenPost('/api/user/reg/setPassword',
        {"password": store.state.setPwd.password,
          "confirmPassword": store.state.setPwd.confirmPassword,
        }, (data) => {
        print("success"+data),
        response = data,
        }, (data) => {
        print("failure"+data),
        response = data,
        });
    return response;
  }

  static changePwd(store, value) {
    if (store.state.setPwd.password != value) {
      store.dispatch(new ChangePassWordAction(value));
      if (store.state.setPwd.pwdError != null &&
          store.state.setPwd.pwdError) {
        store.dispatch(new PwdErrorAction(null));
      }
    }
  }

  static checkPwd(store) {
    String str = store.state.setPwd.password.toString();
    if (str.length >= 6 && str.length <= 8) {
      store.dispatch(new PwdErrorAction(false));
    } else {
      store.dispatch(new PwdErrorAction(true));
    }

  }

  static changeConfirmPwd(store, value) {

    if (store.state.setPwd.confirmPassword != value) {
      store.dispatch(new ChangeConfirmPwdAction(value));
      if (store.state.setPwd.confirmPwdError != null &&
          store.state.setPwd.confirmPwdError) {
        store.dispatch(new ConfirmPwdErrorAction(null));
      }
    }
  }

  static checkConfirmPwd(store) {
    String pwd = store.state.setPwd.password.toString();
    String conFirmpwPwd = store.state.setPwd.confirmPassword.toString();
    if ( pwd == conFirmpwPwd) {
      store.dispatch(new ConfirmPwdErrorAction(false));
    } else {
      store.dispatch(new ConfirmPwdErrorAction(true));
    }

  }
}

class GetPassWordAction {
  final PassWord setPwd;

  GetPassWordAction(this.setPwd);
}

class ChangePassWordAction {
  final String password;
  ChangePassWordAction(this.password);
}

class ChangeConfirmPwdAction {
  final String confirmPassword;

  ChangeConfirmPwdAction(this.confirmPassword);
}


class PwdErrorAction {
  final bool pwdError;

  PwdErrorAction(this.pwdError);
}

class ConfirmPwdErrorAction {
  final bool confirmPwdError;

  ConfirmPwdErrorAction(this.confirmPwdError);
}
