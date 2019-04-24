import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/dao.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';

final screen = ScreenUtil.getInstance();

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new RegisterHome(), 'opacity'),
    );
  }
}

class RegisterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(
              screen.setWidth(13), screen.setWidth(33), 0, 0),
          child: new IconButton(
              icon: new Image.asset('images/back_normal.png'),
              onPressed: () {
                print('返回登录页');
                Navigator.pop(context);
              }),
        ),
        new RegisterContent()
      ],
    );
  }
}

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> with SingleTickerProviderStateMixin{
  bool visible = false;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _postController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();


  Animation<double> animation;
  AnimationController controller;

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    double w = screen.setWidth(329.0);
    controller = AnimationController(
      duration: Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(
      begin: w,
      end: w - 260,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });

  }


  @override
  Widget build(BuildContext context) {
    //final mediaQueryWith = MediaQuery.of(context);
    //final displayHeight = mediaQueryWith.size.width;

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.fromLTRB(
              0, screen.setWidth(57), 0, screen.setWidth(15)),
          child: new Image.asset(
            'images/testlogin.png',
          ),
        ),

        new Container(
          margin: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(38)),
          child: new Text(
            '-----',
            style: TextStyle(color: Colors.white),
          ),
        ),

        new Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new TextField(
            controller: _userNameController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            maxLength: 10,
            style:
            new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
            decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: '真实姓名？',
                hintStyle: new TextStyle(
                    color: const Color(0xFF646464),
                    fontSize: screen.setSp(16))),
            onChanged: (value) {
              cheakInput(value);
            },
          ),
        ),

        new Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new TextField(
            controller: _phonenumberController,
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            maxLength: 11,
            style:
            new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
            decoration: new InputDecoration(
              //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                border: InputBorder.none,
                hintText: '手机号？',
                hintStyle: new TextStyle(
                    color: const Color(0xFF646464),
                    fontSize: screen.setSp(16))),
            onChanged: (value) {
              cheakInput(value);
            },
          ),
        ),

        new Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            maxLength: 50,
            style:
            new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
            decoration: new InputDecoration(
              //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                border: InputBorder.none,
                hintText: '邮箱？',
                hintStyle: new TextStyle(
                    color: const Color(0xFF646464),
                    fontSize: screen.setSp(16))),
            onChanged: (value) {
              cheakInput(value);
            },
          ),
        ),

        new Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new TextField(
            controller: _postController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            maxLength: 10,
            style:
            new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
            decoration: new InputDecoration(
              //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                border: InputBorder.none,
                hintText: '职务？',
                hintStyle: new TextStyle(
                    color: const Color(0xFF646464),
                    fontSize: screen.setSp(16))),
            onChanged: (value) {
              cheakInput(value);
            },
          ),
        ),

        new Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(67)),
          child: new TextField(
            controller: _companyController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            maxLength: 20,
            style:
            new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
            decoration: new InputDecoration(
              //contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                border: InputBorder.none,
                hintText: '所属公司？',
                hintStyle: new TextStyle(
                    color: const Color(0xFF646464),
                    fontSize: screen.setSp(16))),
            onChanged: (value) {
              cheakInput(value);
            },
          ),
        ),

        new Container(
          margin: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(8)),
          child: new Opacity(
            opacity: visible ? 1.0 : 0.2,
            child: new IconButton(
                icon: new Image.asset('images/back_normal.png'),
                onPressed: () {
                  if (visible) {
                    print('点击了');
                    uploadData();
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                          return new RegisterPwd();
                        }));
                  }
                }),
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

  }

  void cheakInput(String value) {
    if (_userNameController.text.isNotEmpty &&
        _phonenumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _postController.text.isNotEmpty &&
        _companyController.text.isNotEmpty) {
      visible = true;
      setState(() {
        controller.forward();
      });
    } else {
      visible = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  ///上传用户信息
  void uploadData() async {
    //var result = await Dao.noTokenPost('/api/user/reg', {});
  }
}
