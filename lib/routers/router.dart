import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/login_page/login_input.dart';
import 'package:wm_library/views/register_page/register.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';

class Routers {
  var _routers = {
    '/login': (context) => new Login(),
    '/login-input': (context) => new LoginInput(),
    '/register': (context) => new Register(),
    '/register_pwd': (context) => new RegisterPwd(),
  };

  get router => _routers;
}
