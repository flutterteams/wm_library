import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/register/password.dart';
import 'package:wm_library/redux/app_reducer.dart';

class SetPassWordActionCreator {
  static setPassWord(Store<AppState> store) {
    print(store.state.setPwd.password);
    store.dispatch(new GetPassWordAction(new PassWord(store.state.setPwd.password,store.state.setPwd.confirmPassword)));

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
    store.dispatch(new ChangepasswordAction(value));
  }

  static changeConfirmPwd(store, value) {
    store.dispatch(new ChangeConfirmPwdAction(value));
  }

}

class GetPassWordAction {
  final PassWord setPwd;

  GetPassWordAction(this.setPwd);
}

class ChangepasswordAction {
  final String password;
  ChangepasswordAction(this.password);
}

class ChangeConfirmPwdAction {
  final String confirmPassword;

  ChangeConfirmPwdAction(this.confirmPassword);
}


