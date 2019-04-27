import 'package:redux/redux.dart';
import 'package:wm_library/actions/register.dart';
import 'package:wm_library/model/register/register.dart';

final registerReducer = combineReducers<Register>([
  TypedReducer<Register, GetRegisterAction>(_changeAll),
  TypedReducer<Register, ChangeNameAction>(_changeName),
  TypedReducer<Register, ChangePhoneAction>(_changePhone),
  TypedReducer<Register, ChangeEmailAction>(_changeEmail),
  TypedReducer<Register, ChangePositionAction>(_changePosition),
  TypedReducer<Register, ChangeCompanyIdAction>(_changeCompanyId),

  TypedReducer<Register, NameErrorAction>(_checkName),
  TypedReducer<Register, PhoneErrorAction>(_checkPhone),
  TypedReducer<Register, EmailErrorAction>(_checkEmail),
  TypedReducer<Register, PositionErrorAction>(_checkPosition),
  TypedReducer<Register, CompanyErrorAction>(_checkCompany),
]);


Register _changeAll(Register register, action) {
  register = action.register;
  return register;

}

Register _changeName(Register register, action) {
  register.name = action.name == '' ? null : action.name;
  return register;
}

Register _changePhone(Register register, action) {
  register.phone = action.phone == '' ? null : action.phone;
  return register;
}

Register _changeEmail(Register register, action) {
  register.email = action.email == '' ? null : action.email;
  return register;
}

Register _changePosition(Register register, action) {
  register.position = action.position == '' ? null : action.position;
  return register;
}

Register _changeCompanyId(Register register, action) {
  register.company_id = action.company_id == '' ? null : action.company_id;
  return register;
}


// phone 输入格式错误
Register _checkName(Register register, action) {
  register.nameError = action.nameError;
  return register;
}

// phone 输入格式错误
Register _checkPhone(Register register, action) {
  register.phoneError = action.phoneError;
  return register;
}

// email 输入格式错误
Register _checkEmail(Register register, action) {
  register.emailError = action.emailError;
  return register;
}

// position 输入格式错误
Register _checkPosition(Register register, action) {
  register.positionError = action.positionError;
  return register;
}

// company_id 输入格式错误
Register _checkCompany(Register register, action) {
  register.companyError = action.companyError;
  return register;
}