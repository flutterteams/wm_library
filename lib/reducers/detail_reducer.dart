import 'package:redux/redux.dart';
import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/review/review.dart';
import 'package:wm_library/actions/detail.dart';

final detailReducer = combineReducers<Map>([
  TypedReducer<Map, ChangeDataAction>(_changeData),
  TypedReducer<Map, ChangeReviewListAction>(_changeReviewList),
//  TypedReducer<Book, ChangeIdAction>(_changeId),
]);


// 获取数据reducer
Map _changeData(Map map, action) {
  if (action.book == null) {
    return map;
  } else {
    map['book'] = action.book;
    return map;
  }
}

// 获取书评列表reducer
Map _changeReviewList(Map map, action) {
  if (action.list == null) {
    return map;
  } else {
    List<Review> list = map.containsKey('list') ? map['list'] : [];
    list = action.list;
    map['list'] = list;
    return map;
  }
}
//
//// 切换分类reducer
//Index _changeId(Index index, action) {
//  index.id = action.id;
//  return index;
//}

