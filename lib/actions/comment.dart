import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/comment/comment.dart';
import 'package:wm_library/common/dao.dart';

class CommentActionCreator {
  // 获取书评list
  static getCommentList(store, id) {
    Dao.get('/api/user/commentList', {'reviewId': id.toString()}, (data) {
      List<Comment> list = new List();

      List bookMap = data['data'];

      if (bookMap.length > 0) {
        for (var item in bookMap) {
          list.add(Comment.fromJson(item));
        }
      }

      store.dispatch(new ChangeCommentListAction(list));
    }, (data) {
      print(data);
    });
  }
}

/// 获取书评列表action
class ChangeCommentListAction {
  final List list;

  ChangeCommentListAction(this.list);
}
