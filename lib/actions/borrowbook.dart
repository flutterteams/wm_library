import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/redux/app_reducer.dart';

class BorrowBookActionCreator {
  static getBorrowBook(Store<AppState> store) {
    Dao.get('/api/getUserBorrowBooks', {"type":"0"},
            (data) async {
          print(""+data.toString());
          store.dispatch(new GetBorrowBookAction(BorrowBook.fromJson(data)));
        },
            (data) async {
          print("failure3" + data.toString());
        }
    );
  }
}

class GetBorrowBookAction {
  final BorrowBook borrowBook;

  GetBorrowBookAction(this.borrowBook);
}





