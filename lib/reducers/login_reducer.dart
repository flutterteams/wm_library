import 'package:redux/redux.dart';
import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/actions/login.dart';

final loginReducer = combineReducers<Login>([
  TypedReducer<Login, ChangeEmailAction>(_changeEmail),
  TypedReducer<Login, EmailErrorAction>(_checkEmail),
  TypedReducer<Login, ChangePwAction>(_changePw),
  TypedReducer<Login, PwErrorAction>(_checkPw)
]);


// email输入reducer
Login _changeEmail(Login login, action) {
  login.email = action.email == '' ? null : action.email;
  return login;
}

// email输入格式错误
Login _checkEmail(Login login, action) {
  login.emailError = action.emailError;
  login.emailErrorStr = action.emailErrorStr;
  return login;
}

// pw输入reducer
Login _changePw(Login login, action) {
  login.pw = action.pw == '' ? null : action.pw;
  return login;
}

// pw输入格式错误
Login _checkPw(Login login, action) {
  login.pwError = action.pwError;
  login.pwErrorStr = action.pwErrorStr;
  return login;
}

