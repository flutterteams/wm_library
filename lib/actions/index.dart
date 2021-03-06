import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/model/index/index.dart';
import 'package:wm_library/common/dao.dart';

class IndexActionCreator {
  /// 获取Typelist
  static getTypeList(store) {
    Dao.get('/api/bookType', null, (data) {
      List list = [
        {'id': 0, 'name': '推荐'}
      ];
      list.addAll(data['data']);
      store.dispatch(new ChangeTypeListAction(list));
    }, (data) {
      print(data);
    });
  }

  /// 获取list
  static getList(store, id) {
    if (id == 0) {
      Dao.get('/api/user/getRecommendList', null, (data) {
        print(data['data']);
        store.dispatch(new ChangeListAction(data['data']));
      }, (data) {
        print(data);
      });
    } else {
      Dao.get('/api/bookList', {'type_id':store.state.index.typeList[id]['id'].toString(), 'bookStatus': '0'}, (data) {
        store.dispatch(new ChangeListAction(data['data']));
      }, (data) {
        print(data);
      });
    }

  }

  /// 切换分类
  static changeId(store, id) {

    store.dispatch(new ChangeIdAction(id));
    getList(store, id);
  }
}

/// 获取List的action
class ChangeListAction {
  final List list;

  ChangeListAction(this.list);
}

/// 获取类型列表action
class ChangeTypeListAction {
  final List typeList;

  ChangeTypeListAction(this.typeList);
}

/// 切换分类action
class ChangeIdAction {
  final int id;

  ChangeIdAction(this.id);
}
