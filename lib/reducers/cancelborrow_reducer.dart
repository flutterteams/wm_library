import 'package:redux/redux.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/cancelborrow.dart';
import 'package:wm_library/actions/finishbook.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/cancelborrow.dart';
import 'package:wm_library/model/borrowbook/finishbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final cancelborrowReducer = combineReducers<CancelBorrow>([
  TypedReducer<CancelBorrow, IsCancelBorrowAction>(_changeIsCancelborrow),
]);

CancelBorrow _changeIsCancelborrow(CancelBorrow cancelborrow, action) {
  cancelborrow.isCancelborrow = action.isCancelborrow;
  return cancelborrow;
}


