import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/review/review.dart';
import 'package:wm_library/common/dao.dart';

class DetailActionCreator {
  // 获取书评list
  static getReviewList(store, id) {
    Dao.get('/api/user/reviewList', {'bookId': id.toString()}, (data) {
      List<Review> list = new List();

      List bookMap = data['data'];

      if (bookMap.length > 0) {
        for (var item in bookMap) {
          list.add(Review.fromJson(item));
        }
      }

      store.dispatch(new ChangeReviewListAction(list));
    }, (data) {
      print(data);
    });
  }

  /// 获取数据
  static getData(store, id) {

      Dao.get('/api/bookDetails', {'bookId' : id.toString()}, (data) {
        print(data);
        store.dispatch(new ChangeDataAction(Book.fromJson(data['data'][0])));
      }, (data) {
        print(data);
      });


  }

//  /// 切换分类
//  static changeId(store, id) {
//    store.dispatch(new ChangeIdAction(id));
//  }
}

/// 获取List的action
class ChangeDataAction {
  final Book book;

  ChangeDataAction(this.book);
}

/// 获取书评列表action
class ChangeReviewListAction {
  final List list;

  ChangeReviewListAction(this.list);
}
//
///// 切换分类action
//class ChangeIdAction {
//  final int id;
//
//  ChangeIdAction(this.id);
//}
