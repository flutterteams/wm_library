import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/login_page/login_input.dart';

class Routers {
  var _routers = {
    '/login': (context) => new Login(),
    '/login-input': (context) => new LoginInput()
  };

  get router => _routers;
}
