import 'package:redux/redux.dart';
import 'package:wm_library/actions/borrowbook.dart';
import 'package:wm_library/actions/cancelborrow.dart';
import 'package:wm_library/actions/commentbook.dart';
import 'package:wm_library/actions/finishbook.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/cancelborrow.dart';
import 'package:wm_library/model/borrowbook/commentbook.dart';
import 'package:wm_library/model/borrowbook/finishbook.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';

final commentBookReducer = combineReducers<CommentBook>([
  TypedReducer<CommentBook, CommentBookAction>(_changeCommentBook),
  TypedReducer<CommentBook, CheakContentAction>(_cheakContent),
  TypedReducer<CommentBook, CheakCommentErrorAction>(_cheakCommentError),
]);


CommentBook _changeCommentBook(CommentBook commentBook, action) {
  commentBook = action.commentBook;
  return commentBook;
}


CommentBook _cheakContent(CommentBook commentBook, action) {
  commentBook.content = action.content;
  return commentBook;
}

CommentBook _cheakCommentError(CommentBook commentBook, action) {
  commentBook.commentError = action.commentError;
  return commentBook;
}


