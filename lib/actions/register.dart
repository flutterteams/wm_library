import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/redux/app_reducer.dart';

class RegisterActionCreator {
  static register(Store<AppState> store) {
    print(store.state.register.email);
    store.dispatch(new GetRegisterAction(new Register(store.state.register.name,
        store.state.register.phone,store.state.register.email,
        store.state.register.position,store.state.register.company_id)));

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
    store.dispatch(new ChangeNameAction(value));
  }

  /// 输入phone监听方法
  static changePhone(store, value) {
    store.dispatch(new ChangePhoneAction(value));
  }
  /// 输入email监听方法
  static changeEmail(store, value) {
    store.dispatch(new ChangeEmailAction(value));
  }

  /// 输入position监听方法
  static changePosition(store, value) {
    store.dispatch(new ChangePositionAction(value));
  }

  /// 输入position监听方法
  static changeCompanyId(store, value) {
    store.dispatch(new ChangeCompanyIdAction(value));
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
