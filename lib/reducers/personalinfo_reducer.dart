import 'package:redux/redux.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final personalInfoReducer = combineReducers<UserInfo>([
  TypedReducer<UserInfo, GetPersonalInfoAction>(_changeAll),
  TypedReducer<UserInfo, ChangeNameAction>(_changeName),
  TypedReducer<UserInfo, ChangeSignAction>(_changeSign),
  TypedReducer<UserInfo, ChangePhoneAction>(_changePhone),
  TypedReducer<UserInfo, ChangeEmailAction>(_changeEmail),
  TypedReducer<UserInfo, ChangePositionAction>(_changePosition),
  TypedReducer<UserInfo, ChangeCompanyIdAction>(_changeCompanyId),

  TypedReducer<UserInfo, SignErrorAction>(_checkSign),
//  TypedReducer<UserInfo, PhoneErrorAction>(_checkPhone),
//  TypedReducer<UserInfo, EmailErrorAction>(_checkEmail),
  TypedReducer<UserInfo, PositionErrorAction>(_checkPosition),
  TypedReducer<UserInfo, CompanyErrorAction>(_checkCompany),
//  TypedReducer<UserInfo, IsRegisterAction>(_checkIsRegister),
]);


UserInfo _changeAll(UserInfo userInfo, action) {
  userInfo = action.userInfo;
  return userInfo;

}

UserInfo _changeName(UserInfo userInfo, action) {
  userInfo.data.name = action.name == '' ? null : action.name;
  return userInfo;
}

UserInfo _changeSign(UserInfo userInfo, action) {
  userInfo.data.signature = action.signature == '' ? null : action.signature;
  return userInfo;
}

UserInfo _changePhone(UserInfo userInfo, action) {
  userInfo.data.phone = action.phone == '' ? null : action.phone;
  return userInfo;
}

UserInfo _changeEmail(UserInfo userInfo, action) {
  userInfo.data.email = action.email == '' ? null : action.email;
  return userInfo;
}

UserInfo _changePosition(UserInfo userInfo, action) {
  userInfo.data.position = action.position == '' ? null : action.position;
  return userInfo;
}

UserInfo _changeCompanyId(UserInfo userInfo, action) {
  userInfo.data.company_id = action.company_id == '' ? null : action.company_id;
  return userInfo;
}


// sign 输入格式错误
UserInfo _checkSign(UserInfo userInfo, action) {
  userInfo.data.signError = action.signError;
  return userInfo;
}
//
//// phone 输入格式错误
//UserInfo _checkPhone(UserInfo userInfo, action) {
//  userInfo.phoneError = action.phoneError;
//  return userInfo;
//}
//
//// email 输入格式错误
//UserInfo _checkEmail(UserInfo userInfo, action) {
//  userInfo.emailError = action.emailError;
//  return userInfo;
//}

// position 输入格式错误
UserInfo _checkPosition(UserInfo userInfo, action) {
  userInfo.data.positionError = action.positionError;
  return userInfo;
}

// company_id 输入格式错误
UserInfo _checkCompany(UserInfo userInfo, action) {
  userInfo.data.companyError = action.companyError;
  return userInfo;
}
//
//// company_id 输入格式错误
//Register _checkIsRegister(Register register, action) {
//  register.isRegister = action.isRegister;
//  return register;
//}