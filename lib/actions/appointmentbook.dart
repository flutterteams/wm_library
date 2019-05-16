import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/borrowbook/appointmentbook.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/redux/app_reducer.dart';

class AppointmentBookActionCreator {
  static getAppointmentBook(Store<AppState> store) {
    Dao.get('/api/getUserBorrowBooks', {"type":"1"},
            (data) async {
          print(""+data.toString());
          store.dispatch(new GetAppointmentBookAction(AppointmentBook.fromJson(data)));
        },
            (data) async {
          print("failure3" + data.toString());

        }
    );
  }
}

class GetAppointmentBookAction {
  final AppointmentBook appointmentBook;
  GetAppointmentBookAction(this.appointmentBook);
}





