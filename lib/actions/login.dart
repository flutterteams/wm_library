import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/common/dao.dart';

class LoginActionCreator {
  static login(store) {
    store.dispatch(new GetLoginAction(new Login(1, '123')));
    Dao.noTokenPost('/api/admin/login', {"name": 'admin', "password": 'bjfrog'}, (data) => {
      print(data)
    }, (data) => {
      print(data)
    });
  }
}

class GetLoginAction {
  final Login login;

  GetLoginAction(this.login);
}
