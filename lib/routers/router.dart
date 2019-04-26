import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/login_page/login_input.dart';
import 'package:wm_library/views/login_page/login_input_pw.dart';
import 'package:wm_library/views/login_page/login_success.dart';
import 'package:wm_library/views/register_page/register.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';

class Routers {
  var _routers = {
    '/login': (context) => new Login(),
    '/login-input': (context) => new LoginInput(),
    '/login-input-pw': (context) => new LoginInputPw(),
    '/login-success': (context) => new LoginSuccess(),
    '/register': (context) => new Register(),
    '/register_pwd': (context) => new RegisterPwd(),
  };

  get router => _routers;
}
