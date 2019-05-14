import 'package:redux/redux.dart';
import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/review/review.dart';
import 'package:wm_library/actions/order.dart';

final orderReducer = combineReducers<List>([
  TypedReducer<List, ChangeOrderListAction>(_changeOrderList),
]);

// 获取列表reducer
List _changeOrderList(List list, action) {
  list = action.list;
  return list;
}
