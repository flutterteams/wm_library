import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/borrowbook/appointmentbook.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/redux/app_reducer.dart';

class CancelBorrowActionCreator {
  static cancelBorrow(Store<AppState> store,int id) {
    Dao.post('/api/user/cancelBorrow', {"borrow_id":id.toString()},
            (data) async {
          print(""+data.toString());
          if(data['code'] == 1){
            store.dispatch(new IsCancelBorrowAction(true));
          }
        },
            (data) async {
          print("failure3" + data.toString());
          store.dispatch(new IsCancelBorrowAction(false));
        }
    );
  }
}

class IsCancelBorrowAction {
  final bool isCancelborrow;
  IsCancelBorrowAction(this.isCancelborrow);
}





