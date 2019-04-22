import 'package:redux/redux.dart';
import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/actions/login.dart';

final loginReducer = combineReducers<Login>([
  TypedReducer<Login, GetLoginAction>(_login),
]);


Login _login(Login login, action) {
  login = action.login;
  return login;
}
