
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/actions/password.dart';
import 'package:wm_library/components/scroll_bg/scroll_bg.dart';
import 'package:wm_library/redux/app_reducer.dart';

final screen = ScreenUtil.getInstance();

class RegisterPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new RegisterPwdContent(), 'opacity'),
    );
  }
}
class RegisterPwdHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(
              screen.setWidth(13), screen.setWidth(33), 0, 0),
          child: new IconButton(
              icon: new Image.asset('images/back_normal.png') ,
              onPressed: (){
                print('返回登录页');
                Navigator.pop(context);
              }),
        ),
        new RegisterPwdContent(),
      ],
    );
  }
}

class RegisterPwdContent extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPwdContentState();
  }
}

class _RegisterPwdContentState extends State<RegisterPwdContent> with TickerProviderStateMixin{

  int btnColor = 0xff454545;
  String tips = "";

  Animation<double> animation;
  AnimationController controller;

  Animation<Color> colorAnimation;
  AnimationController controllerColor;

  TextEditingController _userPwdController = new TextEditingController();
  TextEditingController _userRepeatPwdController = new TextEditingController();


  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double w = screen.setWidth(329.0);
    controller = AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);
    animation = new Tween(
      begin: w,
      end: -3.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
    //controller.forward();

    controllerColor = AnimationController(
        duration: Duration(milliseconds: 5), vsync: this);

    colorAnimation = ColorTween(begin: Color(btnColor), end: Color(0xffffffff))
        .animate(CurvedAnimation(
      parent: controllerColor,
      curve: Curves.ease,
    ))

      ..addListener(() {})
      ..addStatusListener((status) {});
  }

  @override
  Widget build(BuildContext context) {
//    final _colorValue =
//    colorAnimation == null ? Color(btnColor) : colorAnimation.value;

    return new StoreBuilder<AppState>(builder: (context, store) {

      return new Stack(
        children: <Widget>[
          new Container(
            height: screen.setWidth(33),
            alignment: Alignment.topLeft,
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(20), 0, 0),
            child: new IconButton(
                padding: new EdgeInsets.all(screen.setWidth(13)),
                alignment: Alignment.topLeft,
                icon: new Icon(Icons.arrow_back_ios),
                color: const Color(0xffbbbbbb),
                iconSize: screen.setWidth(20),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(109), 0, 0),
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(15)),
                  child: new Image.asset('images/sign_in.png',),
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(15), 0, 0),
                  height: screen.setWidth(1),
                  width: screen.setWidth(50),
                  color: Colors.white,
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(65), 0, 0),
                  child: new TextField(
                    controller: _userPwdController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLength: 8,
                    obscureText: true,
                    style: new TextStyle(color: Colors.white,fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: '密码？',
                        hintStyle: new TextStyle(color: const Color(0xFF646464),fontSize: screen.setSp(18))
                    ),
                    onChanged: (value){
                      SetPassWordActionCreator.changePwd(store, value);
                      cheakInput();
                    },
                    inputFormatters: [
                      //WhitelistingTextInputFormatter(RegExp("^[\u4e00-\u9fa5_a-zA-Z0-9]+\$")),
                      WhitelistingTextInputFormatter(RegExp("[A-Za-z0-9]")),
                    ],
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(44), 0, 0),
                  child: new TextField(
                    controller: _userRepeatPwdController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLength: 8,
                    obscureText: true,
                    style: new TextStyle(color: Colors.white,fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: '确认密码？',
                        hintStyle: new TextStyle(color: const Color(0xFF646464),fontSize: screen.setSp(18))
                    ),
                    onChanged: (value){
                      SetPassWordActionCreator.changeConfirmPwd(store, value);
                      cheakInput();
                    },
                    inputFormatters: [
                      //WhitelistingTextInputFormatter(RegExp("^[\u4e00-\u9fa5_a-zA-Z0-9]+\$")),
                      //WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                      WhitelistingTextInputFormatter(RegExp("[A-Za-z0-9]")),
                    ],
                  ),
                ),
                new Container(

                  margin: new EdgeInsets.fromLTRB(
                      0, screen.setWidth(139), 0, screen.setWidth(16)),
                  child: new FlatButton(
                    onPressed: () {
                      print('上传注册信息');
                      uploadData();
                      //Navigator.of(context).pushNamed('/login-input');
                    },
                    child: Image.asset('images/done.png',),
                    color:colorAnimation.value,
                    //color:Color(btnColor),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,

                    padding: EdgeInsets.fromLTRB(
                        screen.setWidth(123),
                        screen.setWidth(13),
                        screen.setWidth(123),
                        screen.setWidth(13)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(screen.setWidth(22)))),
                  ),

                ),
              ],
            ),
          ),

          new Container(
            alignment: Alignment.bottomCenter,
            child: new Container(
              height: screen.setWidth(56),
              alignment: Alignment.topCenter,
              transform: Matrix4.translationValues(0.0, animation.value, 0.0),
              color: const Color(0xffDD412A),
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(0, screen.setWidth(10), 0, 0),
                child: new Text(
                  tips,
                  style: TextStyle(color:Colors.white, fontSize: screen.setSp(18)),
                ),
              ),
            ),
          ),

        ],
      );
    });
  }

  void cheakInput() {

    controller.reverse();
    if(_userPwdController.text.isNotEmpty && _userRepeatPwdController.text.isNotEmpty){

      btnColor = 0xffFFFFFF;
      setState(() {
        controllerColor.forward();
      });
      SetPassWordActionCreator.checkPwd(_getStore());
      SetPassWordActionCreator.checkConfirmPwd(_getStore());

    }else{
      btnColor = 0xff454545;

      setState(() {
        controllerColor.reset();
      });
    }
  }

  ///上传信息
  void uploadData() async {
    print('密码 ${_userPwdController.text.toString()}');


    if(_getStore().state.setPwd.password != null){
      if(_getStore().state.setPwd.pwdError ){
        tips = "密码格式错误";
        initErrorTips();
        return;
      }
    }

    if(_getStore().state.setPwd.confirmPassword != null){
      if(_getStore().state.setPwd.confirmPwdError){
        tips = "两次输入密码不一致";
        initErrorTips();
        return;
      }
    }



    var results = SetPassWordActionCreator.setPassWord(_getStore());
    print(results);
//    Navigator.push(context,
//        new MaterialPageRoute(builder: (context) {
//          return new RegisterPwd();
//        }));

    //Navigator.of(context).pushNamed('/register_pwd');
  }


  ///错误提示
  void initErrorTips() {
    controller.forward();
    setState(() {
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controllerColor.dispose();
    super.dispose();
  }
}