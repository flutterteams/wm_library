import 'package:redux/redux.dart';
import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/review/review.dart';
import 'package:wm_library/actions/comment.dart';

final commentReducer = combineReducers<List>([
  TypedReducer<List, ChangeCommentListAction>(_changeCommentList),
]);

// 获取评论列表reducer
List _changeCommentList(List list, action) {
  list = action.list;
  return list;
}
