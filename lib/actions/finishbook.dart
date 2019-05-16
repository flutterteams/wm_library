import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/finishbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/redux/app_reducer.dart';

class FinishBookActionCreator {
  static getFinishBook(Store<AppState> store) {
    Dao.get('/api/getUserBorrowBooks', {"type":"2"},
            (data) async {
          print(""+data.toString());
          store.dispatch(new GetFinishBookAction(FinishBook.fromJson(data)));
        },
            (data) async {
          print("failure3" + data.toString());
        }
    );
  }
}

class GetFinishBookAction {
  final FinishBook finishBook;

  GetFinishBookAction(this.finishBook);
}





