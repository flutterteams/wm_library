import 'package:redux/redux.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/actions/register.dart';

final registerReducer = combineReducers<List<Register>>([
  TypedReducer<List<Register>, GetRegisterAction>(_register),
]);

List<Register> _register(List<Register> list, action) {
  list.clear();

  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}