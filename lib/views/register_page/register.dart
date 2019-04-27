import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/actions/register.dart';

import 'package:wm_library/components/scroll_bg/scroll_bg.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';

final screen = ScreenUtil.getInstance();

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ScrollBg(new RegisterContent(), 'opacity'),
    );
  }
}

class RegisterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: screen.setWidth(33),
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

          ],
        ),
        new RegisterContent(),
      ],
    );

  }
}

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> with TickerProviderStateMixin{
  bool visible = false;
  String tips = "";
  String companyName = "";
  int btnColor = 0xff454545;
  int btnColor2 = 0xffffffff;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _postController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();


  Animation<double> animation;
  AnimationController controller;

  Animation<Color> colorAnimation;
  AnimationController controllerColor;


  FocusNode _focusNode = FocusNode();

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    double w = screen.setWidth(329.0);
    controller = AnimationController(
      duration: Duration(milliseconds: 800), vsync: this);
    animation = new Tween(
      begin: w,
      end: - 3.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });

    controllerColor = AnimationController(
        duration: Duration(milliseconds: 10), vsync: this);

    colorAnimation = ColorTween(begin: Color(btnColor), end: Color(btnColor2))
        .animate(CurvedAnimation(
      parent: controllerColor,
      curve: Curves.ease,
    ))
      ..addListener(() {})
      ..addStatusListener((status) {});

    // 监听焦点
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        initShowBottowSheet();
      } else {
      }
    });

  }

  @override
  Widget build(BuildContext context) {
//    final mediaQueryWith = MediaQuery.of(context);
//    final h = mediaQueryWith.size.height;
//    final w = mediaQueryWith.size.width;
    return new StoreBuilder<AppState>(builder: (context,store){
      return  new Stack(
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
                  alignment: Alignment.center,
                  child: new Image.asset(
                    'images/sign_in.png',
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(15), 0, 0),
                  height: screen.setWidth(1),
                  width: screen.setWidth(50),
                  color: Colors.white,
                ),

                new Padding(
                  padding: new EdgeInsets.fromLTRB(0, screen.setWidth(38), 0, 0),
                  child: new TextField(
                    controller: _userNameController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLength: 10,
                    style:
                    new TextStyle(color: Colors.white, fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '真实姓名？',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(18))
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5a-zA-Z]")),
                    ],
                    onChanged: (valueName) {
                      print('=====_userNameController===');
                      RegisterActionCreator.changeName(store, valueName);
                      cheakInput();
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
                    new TextStyle(color: Colors.white, fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '手机号？',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(18))),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ],
                    onChanged: (valuePhone) {
                      RegisterActionCreator.changePhone(store, valuePhone);
                      cheakInput();
                    },

                  ),
                ),

                new Padding(
                  padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    maxLength: 30,
                    style:
                    new TextStyle(color: Colors.white, fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '邮箱？',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(18))),
                    onChanged: (valueEmail) {
                      RegisterActionCreator.changeEmail(store, valueEmail);
                      cheakInput();
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
                    new TextStyle(color: Colors.white, fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: '职务？',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(18))),
                    inputFormatters: [
                      //WhitelistingTextInputFormatter(RegExp("^[\u4e00-\u9fa5a-zA-Z]+\$")),
                      WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5a-zA-Z]")),
                    ],
                    onChanged: (valuePosition) {
                      RegisterActionCreator.changePosition(store, valuePosition);
                      cheakInput();
                    },
                  ),
                ),

                new Padding(
                  padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(30)),
                  child:
                  new TextField(
                    //controller: _companyController,
                    controller: TextEditingController.fromValue(TextEditingValue(
                        text: companyName,
                        selection: TextSelection.fromPosition(TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: companyName.length))
                    )),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLength: 20,
                    style:
                    new TextStyle(color: Colors.white, fontSize: screen.setSp(18)),
                    decoration: new InputDecoration(
                      //contentPadding: EdgeInsets.all(0),

                        border: InputBorder.none,
                        hintText: '所属公司？',
                        hintStyle: new TextStyle(
                            color: const Color(0xFF646464),
                            fontSize: screen.setSp(18))),
                    focusNode: _focusNode,
                    onChanged: (valueCompanyId) {
//                      print('9999999');
//                      RegisterActionCreator.changeCompanyId(store, valueCompanyId);
//                      cheakInput();
                    },
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(screen.setWidth(157), 0, screen.setWidth(157), screen.setWidth(8)),
                  child: new Opacity(
                    //opacity: visible ? 1.0 : 0.4,
                    //opacity: colorAnimation.value,
                    opacity: 1.0,
                    child: new FlatButton(
                      onPressed: () {
                        if (visible) {
                          print('点击了');

                          uploadData();
                        }
                      },
                      child: Image.asset('images/group.png',),
                      color: colorAnimation.value,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          screen.setWidth(16),
                          screen.setWidth(18),
                          screen.setWidth(16),
                          screen.setWidth(18)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(screen.setWidth(30)))),
                    ),
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
                  style: TextStyle(color:Colors.white, fontSize: screen.setSp(16)),
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
    //print("====_userName====="+ _userNameController.text.toString());
    print("====companyName====="+ companyName.toString());
    //print("========="+ _emailController.text.toString());
    //print("========="+ _postController.text.toString());
    //print("========="+ _companyController.text.toString());

    if (_userNameController.text.isNotEmpty &&
        _phonenumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _postController.text.isNotEmpty &&
        companyName.toString().isNotEmpty) {

      print("====company====="+ companyName.toString());

      controllerColor.forward();
      visible = true;
//      setState(() {
//
//      });

      RegisterActionCreator.checkName(_getStore());
      RegisterActionCreator.checkPhone(_getStore());
      RegisterActionCreator.checkEmail(_getStore());
      RegisterActionCreator.checkPosition(_getStore());
      RegisterActionCreator.checkCompanyId(_getStore());


    } else {
      print('-----else------');
      controllerColor.reset();
      visible = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controllerColor.dispose();
    super.dispose();
  }

  ///上传用户信息
  void uploadData() async {
    print('用户信息 ${_userNameController.text.toString()}');

    if(_getStore().state.register.name != null){
      if(_getStore().state.register.nameError ){
        tips = "请输入正确的姓名";
        initErrorTips();
        return;
      }
    }
    if(_getStore().state.register.phone != null){
      if(_getStore().state.register.phoneError){
        tips = "请输入正确的手机号";
        initErrorTips();
        return;
      }
    }
    if(_getStore().state.register.email != null){
      if(_getStore().state.register.emailError ){
        tips = "请输入正确的邮箱";
        initErrorTips();
        return;
      }
    }
    if(_getStore().state.register.position != null){
      if(_getStore().state.register.positionError ){
        tips = "请输入正确的职务";
        initErrorTips();
        return;
      }
    }
    if(_getStore().state.register.company_id != null){
      if(_getStore().state.register.companyError ){
        tips = "请选择所属的公司";
        initErrorTips();
        return;
      }
    }

    var results = RegisterActionCreator.register(_getStore());
    print(results);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) {
          return new RegisterPwd();
        }));

    Navigator.of(context).pushNamed('/register_pwd');
  }

  ///错误提示
  void initErrorTips() {
    //visible = false;
    controller.forward();
    setState(() {
    });
  }

  void initShowBottowSheet() {
    //FocusScope.of(context).requestFocus(FocusNode());
    _focusNode.unfocus();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text("广州总部",style: TextStyle(fontSize: screen.setSp(18)),),
                onPressed: (){
                  companyName = "广州总部";
                  selectedValue(companyName);
                },
              ),
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text("北京分公司",style: TextStyle(fontSize: screen.setSp(18)),),
                onPressed: (){
                  companyName = "北京分公司";
                  selectedValue(companyName);
                },
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(15)),
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Text("沈阳分公司",style: TextStyle(fontSize: screen.setSp(18)),),
                  onPressed: (){
                    companyName = "沈阳分公司";
                    selectedValue(companyName);
                  },
                ),
              ),

            ],
          );
        }
    );
  }

  void selectedValue(String companyName) {
    Navigator.pop(context);
    RegisterActionCreator.changeCompanyId(_getStore(), companyName);
    cheakInput();
    setState(() {

    });
  }
}
