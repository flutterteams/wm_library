import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/redux/app_reducer.dart';

class PersonalInfoActionCreator {
  static PersonalInfo(Store<AppState> store) {
    Dao.get('/api/user/userInfo', null,
        (data) async {
            print(data);
            store.dispatch(new GetPersonalInfoAction(UserInfo.fromJson(data)));
        },
        (data) async {
            print("failure3"+data.toString());
        }
    );
  }
  static UpdatePersonalInfo(Store<AppState> store,) {
    print("===UpdatePersonalInfo===");
    Dao.post('/api/user/updateUserInfo', {
      "signature": store.state.userInfo.data.signature == null ? null :store.state.userInfo.data.signature.toString(),
      "position": store.state.userInfo.data.position.toString(),
      "company_id": store.state.userInfo.data.company_id.toString(),
    },
            (data) async {
          print(data);
        },
            (data) async {
          print("failure3"+data.toString());
        }
    );
  }

  static changeName(store, value) {
    if (store.state.userInfo.data.name != value) {
      store.dispatch(new ChangeNameAction(value));
      if (store.state.userInfo.data.nameError != null &&
          store.state.userInfo.data.nameError) {
        //store.dispatch(new NameErrorAction(null));
      }
    }
  }

  static checkName(store) {
    String str = store.state.userInfo.data.name.toString();
    if (str.isNotEmpty && str.length <= 10) {
      //store.dispatch(new NameErrorAction(false));
    } else {
      //store.dispatch(new NameErrorAction(true));
    }
  }


  /// 签名监听方法
  static changeSign(store, value) {
    if (store.state.userInfo.data.signature != value) {
      store.dispatch(new ChangeSignAction(value));
      if (store.state.userInfo.data.signError != null &&
          store.state.userInfo.data.signError) {
        store.dispatch(new SignErrorAction(null));
      }
    }
  }

  static checkSign(store) {
    print("=====checkSign======");
    String str = store.state.userInfo.data.signature.toString();
    if (str.isNotEmpty && str.length <= 10) {
      store.dispatch(new SignErrorAction(false));
    } else {
      store.dispatch(new SignErrorAction(true));
    }
  }


  /// 输入position监听方法
  static changePosition(store, value) {
    if (store.state.userInfo.data.position != value) {
      if(value.isEmpty){
        value = "";
      }
      store.dispatch(new ChangePositionAction(value));
      if (store.state.userInfo.data.positionError != null &&
          store.state.userInfo.data.positionError) {
        store.dispatch(new PositionErrorAction(null));
      }
    }
  }

  static checkPosition(store) {
    String str = store.state.userInfo.data.position;
    if (str.length > 0 && str.length <= 10) {
      store.dispatch(new PositionErrorAction(false));
    } else {
      store.dispatch(new PositionErrorAction(true));
    }
  }


  static changeCompanyId(store, value) {
    if (store.state.userInfo.data.company_id != value) {
      store.dispatch(new ChangeCompanyIdAction(value));
      if (store.state.userInfo.data.companyError != null &&
          store.state.userInfo.data.companyError) {
        store.dispatch(new CompanyErrorAction(null));
      }
    }
  }


  static checkCompanyId(store) {
    String str = store.state.userInfo.data.company_id.toString();
    if (str.length > 0 && str.length <= 20) {
      store.dispatch(new CompanyErrorAction(false));
    } else {
      store.dispatch(new CompanyErrorAction(true));
    }
  }
}

class GetPersonalInfoAction {
  final UserInfo userInfo;


  GetPersonalInfoAction(this.userInfo);
}

class ChangeNameAction {
  final String name;
  ChangeNameAction(this.name);
}

class ChangeSignAction {
  final String signature;
  ChangeSignAction(this.signature);
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
  final int company_id;

  ChangeCompanyIdAction(this.company_id);
}

class SignErrorAction {
  final bool signError;
  SignErrorAction(this.signError);
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




