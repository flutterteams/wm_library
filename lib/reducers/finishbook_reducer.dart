import 'package:redux/redux.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/finishbook.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/finishbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final finishBookReducer = combineReducers<FinishBook>([
  TypedReducer<FinishBook, GetFinishBookAction>(_changeAll),
  //TypedReducer<BorrowBook, ChangeSignAction>(_changeSign),

  //TypedReducer<BorrowBook, SignErrorAction>(_checkSign),

]);

FinishBook _changeAll(FinishBook finishBook, action) {
  finishBook = action.finishBook;
  return finishBook;

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


