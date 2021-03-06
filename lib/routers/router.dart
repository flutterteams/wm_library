import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/login_page/login_input.dart';
import 'package:wm_library/views/login_page/login_input_pw.dart';
import 'package:wm_library/views/login_page/login_success.dart';
import 'package:wm_library/views/index_page/index.dart';
import 'package:wm_library/views/mybook_page/mybooks.dart';
import 'package:wm_library/views/personal_page/personal.dart';
import 'package:wm_library/views/personal_page/personal_information.dart';
import 'package:wm_library/views/register_page/register.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';
import 'package:wm_library/views/comment_page/add.dart';

class Routers {
  var _routers = {
    '/login': (context) => new Login(),
    '/login-input': (context) => new LoginInput(),
    '/login-input-pw': (context) => new LoginInputPw(),
    '/login-success': (context) => new LoginSuccess(),
    '/register': (context) => new Register(),
    '/register_pwd': (context) => new RegisterPwd(),
    '/index': (context) => new Index(),
    '/personal': (context) => new Personal(),
    '/mybooks': (context) => new MyBooks(false),
    '/PersonalInformation': (context) => new PersonalInformation(),

  };

  get router => _routers;
}
