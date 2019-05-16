import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';
import 'package:wm_library/model/borrowbook/appointmentbook.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/commentbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/redux/app_reducer.dart';

class CommentBookActionCreator {
  static commentBook(Store<AppState> store,int borrowId) {
    Dao.post('/api/user/addReviewBook', {
      "borrowId":borrowId.toString(),
      "content":store.state.commentBook.content.toString(),
    },
            (data) async {
          print(""+data.toString());
          if(data['code'] == 1){
            store.dispatch(new CheakCommentErrorAction(true));
          }
        },
            (data) async {
          print("failure3" + data.toString());
          store.dispatch(new CheakCommentErrorAction(false));
        }
    );
  }
}

class CommentBookAction {
  final CommentBook commentBook;
  CommentBookAction(this.commentBook);
}

class CheakContentAction {
  final String content;
  CheakContentAction(this.content);
}

class CheakCommentErrorAction {
  final bool commentError;
  CheakCommentErrorAction(this.commentError);
}



