
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/components/scroll_bg/scroll_bg.dart';
import 'package:wm_library/redux/app_reducer.dart';

final screen = ScreenUtil.getInstance();

class RegisterPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new RegisterPwdHome(), 'opacity'),
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

class _RegisterPwdContentState extends State<RegisterPwdContent> with SingleTickerProviderStateMixin{

  int btnColor = 0xff454545;

  Animation<double> animation;
  AnimationController controller;

  TextEditingController _userPwdController = new TextEditingController();
  TextEditingController _userRepeatPwdController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double w = screen.setWidth(329.0);
    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(
      begin: w,
      end: w-160,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
    //controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.fromLTRB(0, screen.setWidth(57), 0, screen.setWidth(15)),
            child: new Image.asset('images/testlogin.png',),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(68)),
            child: new Text('-----',style: TextStyle(color: Colors.white),),
          ),

          new Container(
            child: new TextField(
              controller: _userPwdController,
              keyboardType: TextInputType.numberWithOptions(),
              textAlign: TextAlign.center,
              maxLength: 8,
              obscureText: true,
              style: new TextStyle(color: Colors.white,fontSize: screen.setSp(16)),
              decoration: new InputDecoration(
                //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                  border: InputBorder.none,
                  hintText: '密码？',
                  hintStyle: new TextStyle(color: const Color(0xFF646464),fontSize: screen.setSp(16))
              ),
              onChanged: (value){
                cheakData();
              },
            ),
          ),

          new Container(
            child: new TextField(
              controller: _userRepeatPwdController,
              keyboardType: TextInputType.numberWithOptions(),
              textAlign: TextAlign.center,
              maxLength: 8,
              obscureText: true,
              style: new TextStyle(color: Colors.white,fontSize: screen.setSp(16)),
              decoration: new InputDecoration(
                //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                  border: InputBorder.none,
                  hintText: '确认密码？',
                  hintStyle: new TextStyle(color: const Color(0xFF646464),fontSize: 16.0)
              ),
              onChanged: (value){
                cheakData();
              },
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(139), 0, screen.setWidth(16)),
            child: new FlatButton(
              onPressed: () {
                print('登录');
                cheakPwd();
                Navigator.of(context).pushNamed('/login-input');
              },
              child: new Text(
                'DONE!',
                style: new TextStyle(
                    fontSize: screen.setSp(16),
                    color: const Color(0xff141414),
                    letterSpacing: screen.setWidth(2),
                    height: 1,
                    fontWeight: FontWeight.normal),
              ),
              color: Color(btnColor),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.fromLTRB(
                  screen.setWidth(133),
                  screen.setWidth(12),
                  screen.setWidth(133),
                  screen.setWidth(12)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(screen.setWidth(22)))),
            ),
          ),

          new Container(
            height: screen.setWidth(48),
            alignment: Alignment.center,
            transform: Matrix4.translationValues(0.0, animation.value, 0.0),
            color: const Color(0xffDD412A),
            child: new Text(
              '请输入正确的邮箱',
              style: TextStyle(color:Colors.white, fontSize: screen.setSp(16)),
            ),
          ),

        ],
      );

    });
  }

  void cheakData() {
    if(_userPwdController.text.isNotEmpty && _userRepeatPwdController.text.isNotEmpty
        && _userPwdController.text == _userRepeatPwdController.text){
      btnColor = 0xffFFFFFF;
      setState(() {
        controller.forward();
      });
    }else{
      setState(() {
      });
    }
  }

  void cheakPwd() {

  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}