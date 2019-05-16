import 'package:redux/redux.dart';
import 'package:wm_library/actions/password.dart';
import 'package:wm_library/model/register/password.dart';

final settingPwdReducer = combineReducers<PassWord>([
  TypedReducer<PassWord, GetPassWordAction>(_changeAll),
  TypedReducer<PassWord, ChangePassWordAction>(_changePwd),
  TypedReducer<PassWord, ChangeConfirmPwdAction>(_changeConfirmPwd),

  TypedReducer<PassWord, PwdErrorAction>(_checkPwd),
  TypedReducer<PassWord, ConfirmPwdErrorAction>(_checkConfirmPwd),
  TypedReducer<PassWord, IsSuccessAction>(_checkIsSuccess),

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


PassWord _checkPwd(PassWord passWord, action) {
  passWord.pwdError = action.pwdError;
  return passWord;
}


PassWord _checkConfirmPwd(PassWord passWord, action) {
  passWord.confirmPwdError = action.confirmPwdError;
  return passWord;
}


PassWord _checkIsSuccess(PassWord passWord, action) {
  passWord.isSuccess = action.isSuccess;
  return passWord;
}