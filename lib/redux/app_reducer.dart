import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/model/register/password.dart';

import 'package:wm_library/reducers/login_reducer.dart';
import 'package:wm_library/reducers/password_reducer.dart';
import 'package:wm_library/reducers/register_reducer.dart';

class AppState {
  Login login;
  List<Register> registerList;
  Register register;
  PassWord setPwd;

  ///构造方法
  AppState({this.login, this.registerList,this.register,this.setPwd});

  AppState.initState() {
    login = Login.empty();
    registerList = new List();
    register = Register.empty();
    setPwd = PassWord.empty();
  }
}

AppState appReducer(AppState state, action) {
  return AppState(
      login: loginReducer(state.login, action),
      register: registerReducer(state.register, action),
      setPwd: settingPwdReducer(state.setPwd,action),
  );

}
