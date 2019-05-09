import 'package:redux/redux.dart';
import 'package:wm_library/model/index/index.dart';
import 'package:wm_library/actions/index.dart';

final indexReducer = combineReducers<Index>([
  TypedReducer<Index, ChangeListAction>(_changeList),
  TypedReducer<Index, ChangeTypeListAction>(_changeTypeList),
  TypedReducer<Index, ChangeIdAction>(_changeId),
]);


// 获取列表reducer
Index _changeList(Index index, action) {
  index.list = action.list;
  return index;
}

// 获取图书分类列表reducer
Index _changeTypeList(Index index, action) {
  index.typeList = action.typeList;
  return index;
}

// 切换分类reducer
Index _changeId(Index index, action) {
  index.id = action.id;
  return index;
}

