import 'dart:async';

import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/redux/app_reducer.dart';

class RegisterActionCreator {
  static register(Store<AppState> store) {
    print(store.state.register.email);
//    store.dispatch(new GetRegisterAction(new Register(store.state.register.name,
//        store.state.register.phone,store.state.register.email,
//        store.state.register.position,store.state.register.company_id)));

    Response response;
    Dao.noTokenPost('/api/user/reg',
        {"name": store.state.register.name,
          "phone": store.state.register.phone,
          "email": "hy@frogshealth.com",
          "position": store.state.register.position,
          "company_id": "北分",
        }, (data) => {
        print("success"+data),
        response = data,
        }, (data) => {
        print("failure"+data),
        response = data,
        });
    return response;
  }

  /// 输入user监听方法
  static changeName(store, value) {

    if (store.state.register.name != value) {
      print('Name监听方法');
      store.dispatch(new ChangeNameAction(value));
      if (store.state.register.nameError != null &&
          store.state.register.nameError) {
        print('Name监听方法');
        store.dispatch(new NameErrorAction(null));
      }
    }
  }

  static checkName(store) {
    String str = store.state.register.name.toString();
    if (str.isNotEmpty && str.length <= 10) {
      store.dispatch(new NameErrorAction(false));
    } else {
      store.dispatch(new NameErrorAction(true));
    }
  }

  /// 输入phone监听方法
  static changePhone(store, value) {
    if (store.state.register.phone != value) {
      print('phone监听方法');
      store.dispatch(new ChangePhoneAction(value));
      if (store.state.register.phoneError != null &&
          store.state.register.phoneError) {
        print('phone监听方法222');
        store.dispatch(new PhoneErrorAction(null));
      }
    }
  }

  static checkPhone(store) {
    String str = store.state.register.phone.toString();
    if (str.length == 11) {
      store.dispatch(new PhoneErrorAction(false));
    } else {
      store.dispatch(new PhoneErrorAction(true));
    }
  }

  /// 输入email监听方法
  static changeEmail(store, value) {
    if (store.state.register.email != value) {
      store.dispatch(new ChangeEmailAction(value));
      if (store.state.register.emailError != null &&
          store.state.register.emailError) {
        store.dispatch(new EmailErrorAction(null));
      }
    }
  }

  static checkEmail(store) {
    String str = store.state.register.email.toString();
    if (str.length > 16 && str.endsWith('@frogshealth.com')) {
      store.dispatch(new EmailErrorAction(false));
    } else {
      store.dispatch(new EmailErrorAction(true));
    }
  }

  /// 输入position监听方法
  static changePosition(store, value) {

    if (store.state.register.position != value) {
      store.dispatch(new ChangePositionAction(value));
      if (store.state.register.positionError != null &&
          store.state.register.positionError) {
        store.dispatch(new EmailErrorAction(null));
      }
    }
  }

  static checkPosition(store) {
    String str = store.state.register.position;
    if (str.length > 0 && str.length <= 10) {
      store.dispatch(new PositionErrorAction(false));
    } else {
      store.dispatch(new PositionErrorAction(true));
    }
  }


  static changeCompanyId(store, value) {

    if (store.state.register.company_id != value) {
      store.dispatch(new ChangeCompanyIdAction(value));
      if (store.state.register.companyError != null &&
          store.state.register.companyError) {
        store.dispatch(new CompanyErrorAction(null));
      }
    }
  }


  static checkCompanyId(store) {
    String str = store.state.register.company_id.toString();
    if (str.length > 0 && str.length <= 20) {
      store.dispatch(new CompanyErrorAction(false));
    } else {
      store.dispatch(new CompanyErrorAction(true));
    }
  }
}

class GetRegisterAction {
  final Register register;

  GetRegisterAction(this.register);
}

/// name输入action
class ChangeNameAction {
  final String name;
  ChangeNameAction(this.name);
}

class ChangePhoneAction {
  final String phone;

  ChangePhoneAction(this.phone);
}

class ChangeEmailAction {
  final String email;

  ChangeEmailAction(this.email);
}

class ChangePositionAction {
  final String position;

  ChangePositionAction(this.position);
}

class ChangeCompanyIdAction {
  final String company_id;

  ChangeCompanyIdAction(this.company_id);
}



class NameErrorAction {
  final bool nameError;
  NameErrorAction(this.nameError);
}


class PhoneErrorAction {
  final bool phoneError;
  PhoneErrorAction(this.phoneError);
}

class EmailErrorAction {
  final bool emailError;
  EmailErrorAction(this.emailError);
}

class PositionErrorAction {
  final bool positionError;
  PositionErrorAction(this.positionError);
}

class CompanyErrorAction {
  final bool companyError;

  CompanyErrorAction(this.companyError);
}


