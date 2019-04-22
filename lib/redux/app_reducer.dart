import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/model/register/register.dart';

import 'package:wm_library/reducers/login_reducer.dart';
import 'package:wm_library/reducers/register_reducer.dart';

class AppState {
  Login login;
  List<Register> register;

  ///构造方法
  AppState({this.login, this.register});

  AppState.initState() {
    login = Login.empty();
    register = new List();
  }
}

AppState appReducer(AppState state, action) {
  return AppState(
      login: loginReducer(state.login, action),
      register: registerReducer(state.register, action));
}
