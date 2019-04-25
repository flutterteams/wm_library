import 'package:redux/redux.dart';
import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/actions/login.dart';

final loginReducer = combineReducers<Login>([
  TypedReducer<Login, GetLoginAction>(_login),
  TypedReducer<Login, ChangeEmailAction>(_changeEmail)
]);


Login _login(Login login, action) {
  login = action.login;
  return login;
}

// email输入reducer
Login _changeEmail(Login login, action) {
  login.email = action.email == '' ? null : action.email;
  return login;
}
