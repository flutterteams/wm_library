import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/common/dao.dart';

class LoginActionCreator {
  static login(store) {
    store.dispatch(new GetLoginAction(new Login('1', '123')));

    Dao.noTokenPost('/api/admin/login', {"name": 'admin', "password": 'bjfrog'}, (data) => {
      print(data)
    }, (data) => {
      print(data)
    });
  }

  /// 输入email监听方法
  static changeEmail(store, value) {
    store.dispatch(new ChangeEmailAction(value));
}
}

class GetLoginAction {
  final Login login;

  GetLoginAction(this.login);
}

/// email输入action
class ChangeEmailAction {
  final String email;

  ChangeEmailAction(this.email);
}