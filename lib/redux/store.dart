import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app_reducer.dart';

Store<AppState> createStore() {
  return new Store(appReducer, initialState: AppState.initState(), middleware: [
    // 引入thunk action的中间件
    thunkMiddleware
  ]);
}
