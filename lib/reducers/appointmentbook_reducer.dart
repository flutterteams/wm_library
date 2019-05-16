import 'package:redux/redux.dart';
import 'package:wm_library/actions/appointmentbook.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/borrowbook/appointmentbook.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final appointmentBookReducer = combineReducers<AppointmentBook>([
  TypedReducer<AppointmentBook, GetAppointmentBookAction>(_changeAll),
  //TypedReducer<BorrowBook, ChangeSignAction>(_changeSign),

  //TypedReducer<BorrowBook, SignErrorAction>(_checkSign),

]);

AppointmentBook _changeAll(AppointmentBook appointmentBook, action) {
  appointmentBook = action.appointmentBook;
  return appointmentBook;

}

//BorrowBook _changeSign(BorrowBook borrowBook, action) {
//  borrowBook.data. = action.signature == '' ? null : action.signature;
//  return userInfo;
//}
//
//// sign 输入格式错误
//BorrowBook _checkSign(BorrowBook borrowBook, action) {
//  userInfo.data.signError = action.signError;
//  return userInfo;
//}


