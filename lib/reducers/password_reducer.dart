import 'package:redux/redux.dart';
import 'package:wm_library/actions/password.dart';
import 'package:wm_library/actions/register.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/model/register/password.dart';

final settingPwdReducer = combineReducers<PassWord>([
  TypedReducer<PassWord, GetPassWordAction>(_changeAll),
  TypedReducer<PassWord, ChangeNameAction>(_changePwd),
  TypedReducer<PassWord, ChangePhoneAction>(_changeConfirmPwd),

]);

PassWord _changeAll(PassWord pwd, action) {
  pwd = action.pwd;
  return pwd;

}

PassWord _changePwd(PassWord pwd, action) {
  pwd.password = action.password == '' ? null : action.password;
  return pwd;
}

PassWord _changeConfirmPwd(PassWord pwd, action) {
  pwd.confirmPassword = action.confirmPassword == '' ? null : action.confirmPassword;
  return pwd;
}

