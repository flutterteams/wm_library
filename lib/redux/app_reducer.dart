
import 'package:wm_library/model/book/book.dart';
import 'package:wm_library/model/index/index.dart';

import 'package:wm_library/model/borrowbook/appointmentbook.dart';
import 'package:wm_library/model/borrowbook/borrowbook.dart';
import 'package:wm_library/model/borrowbook/cancelborrow.dart';
import 'package:wm_library/model/borrowbook/commentbook.dart';
import 'package:wm_library/model/borrowbook/finishbook.dart';

import 'package:wm_library/model/login/login.dart';
import 'package:wm_library/model/register/register.dart';
import 'package:wm_library/model/register/password.dart';
import 'package:wm_library/model/userinfo/userinfo.dart';
import 'package:wm_library/reducers/appointmentbook_reducer.dart';
import 'package:wm_library/reducers/borrowbook_reducer.dart';
import 'package:wm_library/reducers/cancelborrow_reducer.dart';
import 'package:wm_library/reducers/commentbook_reducer.dart';
import 'package:wm_library/reducers/finishbook_reducer.dart';

import 'package:wm_library/reducers/comment_reducer.dart';
import 'package:wm_library/reducers/detail_reducer.dart';
import 'package:wm_library/reducers/index_reducer.dart';
import 'package:wm_library/reducers/login_reducer.dart';
import 'package:wm_library/reducers/password_reducer.dart';
import 'package:wm_library/reducers/personalinfo_reducer.dart';
import 'package:wm_library/reducers/register_reducer.dart';
import 'package:wm_library/reducers/order_reducer.dart';

class AppState {
  Login login;
  List<Register> registerList;
  Register register;
  PassWord setPwd;
  Index index;
  Map detail;
  List comment;
  List order;

  UserInfo userInfo;
  BorrowBook borrowBook;
  AppointmentBook appointmentBook;
  FinishBook finishBook;
  CancelBorrow cancelBorrow;
  CommentBook commentBook;

  ///构造方法
  AppState(
      { this.login,
        this.registerList,
        this.register,
        this.setPwd,
        this.index,
        this.detail,
        this.comment,
        this.order,
        this.userInfo,
        this.borrowBook,
        this.appointmentBook,
        this.finishBook,
        this.cancelBorrow,
        this.commentBook
      }
      );

  AppState.initState() {
    login = Login.empty();
    registerList = new List();
    register = Register.empty();
    setPwd = PassWord.empty();
    index = new Index(0, [], []);
    detail = new Map();
    comment = new List();
    order = new List();
    userInfo = UserInfo.empty();
    borrowBook = BorrowBook.empty();
    appointmentBook = AppointmentBook.empty();
    finishBook = FinishBook.empty();
    cancelBorrow = CancelBorrow.empty();
    commentBook = CommentBook.empty();
  }
}

AppState appReducer(AppState state, action) {
  return AppState(
      login: loginReducer(state.login, action),
      register: registerReducer(state.register, action),
      setPwd: settingPwdReducer(state.setPwd, action),
      index: indexReducer(state.index, action),
      detail: detailReducer(state.detail, action),
      comment: commentReducer(state.comment, action),
      order: orderReducer(state.order, action),
      userInfo:personalInfoReducer(state.userInfo,action),
      borrowBook:borrowBookReducer(state.borrowBook,action),
      appointmentBook:appointmentBookReducer(state.appointmentBook,action),
      finishBook:finishBookReducer(state.finishBook,action),
      cancelBorrow:cancelborrowReducer(state.cancelBorrow,action),
      commentBook:commentBookReducer(state.commentBook,action),
  );

}
