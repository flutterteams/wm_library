import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/model/order/order.dart';
import 'package:wm_library/common/dao.dart';

class OrderActionCreator {
  // 获取list
  static getOrderList(store, id) {
    Dao.get('/api/user/getBorrowBookList', {'id': id.toString()}, (data) {
      List<Order> list = new List();

      List bookMap = data['data'];

      if (bookMap.length > 0) {
        for (var item in bookMap) {
          list.add(Order.fromJson(item));
        }
      }
      store.dispatch(new ChangeOrderListAction(list));
    }, (data) {
      print(data);
    });
  }

  // 获取list
  static postOrder(store, id, time, callback) {
    Dao.post('/api/user/borrowBook', {'book_id': id.toString(),'borrow_time': time}, (data) {
      callback(data['data']);
    }, (data) {
      print(data);
    });
  }
}

/// 获取列表action
class ChangeOrderListAction {
  final List list;

  ChangeOrderListAction(this.list);
}
