import 'package:redux/redux.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final borrowBookReducer = combineReducers<BorrowBook>([
  TypedReducer<BorrowBook, GetBorrowBookAction>(_changeAll),
  //TypedReducer<BorrowBook, ChangeSignAction>(_changeSign),

  //TypedReducer<BorrowBook, SignErrorAction>(_checkSign),

]);

BorrowBook _changeAll(BorrowBook borrowBook, action) {
  borrowBook = action.borrowBook;
  return borrowBook;

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


