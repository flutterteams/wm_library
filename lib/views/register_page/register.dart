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
      body: new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
          //print("触摸收起键盘");
        },
        child: new ScrollBg(new RegisterContent(), 'opacity'),
      )
    );
  }
}

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent>
    with TickerProviderStateMixin {
  bool visible = false;
  bool isVisible = true;
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

//    controller = AnimationController(
//      duration: Duration(milliseconds: 800), vsync: this);
//    animation = new Tween(
//      begin: 86.0,
//      end: - 3.0,
//    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
//      ..addListener(() {
//        setState(() {});
//      });

    controllerColor =
        AnimationController(duration: Duration(milliseconds: 20), vsync: this);

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
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {

    double height =  MediaQuery.of(context).size.height; //高度

    double unit2 = height/ 667.0;


    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Stack(
        children: <Widget>[
          new IconButton(
              //padding: new EdgeInsets.only(left: 13 * unit2 ,top: 33 * unit2),
              padding: new EdgeInsets.only(left: screen.setWidth(13),top: screen.setHeight(33)),
              alignment: Alignment.centerLeft,
              icon: new Icon(Icons.arrow_back_ios),
              color: const Color(0xffbbbbbb),
              iconSize: screen.setWidth(20),
              onPressed: () {
                Navigator.pop(context);
              }
          ),

          new Container(
            margin: new EdgeInsets.fromLTRB(0, screen.setHeight(109), 0, 0),
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    child: new Image.asset(
                      'images/sign_in.png',
                    ),
                  ),
                  new Container(
                    margin:
                        new EdgeInsets.fromLTRB(0, screen.setHeight(15), 0, 0),
                    height: screen.setWidth(1),
                    width: screen.setWidth(50),
                    color: Colors.white,
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(
                        0, screen.setHeight(38), 0, screen.setHeight(34)),
                    child: new TextField(
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      cursorColor: Colors.white,
                      style: new TextStyle(
                          color: Colors.white, fontSize: screen.setSp(18)),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          counterText: "",
                          hintText: '真实姓名？',
                          hintStyle: new TextStyle(
                              color: const Color(0xFF646464),
                              fontSize: screen.setSp(18))),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(
                            RegExp("[\u4e00-\u9fa5a-zA-Z]")),
                      ],
                      onChanged: (valueName) {
                        RegisterActionCreator.changeName(store, valueName);
                        cheakInput();
                      },
                    ),
                  ),
                  new Padding(
                    padding:
                        new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(34)),
                    child: new TextField(
                      controller: _phonenumberController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      maxLength: 11,
                      cursorColor: Colors.white,
                      style: new TextStyle(
                          color: Colors.white, fontSize: screen.setSp(18)),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          counterText: "",
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
                    padding:
                        new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(34)),
                    child: new TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      style: new TextStyle(
                          color: Colors.white, fontSize: screen.setSp(18)),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
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
                    padding:
                        new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(34)),
                    child: new TextField(
                      controller: _postController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      cursorColor: Colors.white,
                      style: new TextStyle(
                          color: Colors.white, fontSize: screen.setSp(18)),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          counterText: "",
                          hintText: '职务？',
                          hintStyle: new TextStyle(
                              color: const Color(0xFF646464),
                              fontSize: screen.setSp(18))),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(
                            RegExp("[\u4e00-\u9fa5a-zA-Z]")),
                      ],
                      onChanged: (valuePosition) {
                        RegisterActionCreator.changePosition(
                            store, valuePosition);
                        cheakInput();
                      },
                    ),
                  ),
                  new Padding(
                    padding:
                        new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(67)),
                    child: new TextField(
                      //controller: _companyController,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: companyName,
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: companyName.length)))),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 20,
                      style: new TextStyle(
                          color: Colors.white, fontSize: screen.setSp(18)),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          counterText: "",
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
                    margin: new EdgeInsets.fromLTRB(screen.setWidth(157), 0,
                        screen.setWidth(157), screen.setHeight(8)),
                    child: new Opacity(
                      opacity: visible ? 1.0 : 0.6,
                      //opacity: colorAnimation.value,
                      //opacity: 1.0,
                      child: new FlatButton(
                        onPressed: () {
                          if (visible) {
                            //print('点击了');
                            uploadData();
                          }
                        },
                        child: Image.asset(
                          'images/group.png',
                        ),
                        //color: colorAnimation.value,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        color: Color(visible ? 0xFFFFFFFF : 0xFF646464),
                        padding: EdgeInsets.fromLTRB(
                            screen.setWidth(16),
                            screen.setWidth(18),
                            screen.setWidth(16),
                            screen.setWidth(18)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screen.setWidth(30))
                            ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }, onDidChange: (store) {
      _onDidChange(store);
    });
  }

  void cheakInput() {
    if (_userNameController.text.isNotEmpty &&
        _phonenumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _postController.text.isNotEmpty &&
        companyName.isNotEmpty) {
      visible = true;
      controllerColor.forward();
      //controllerColor.forward();
      setState(() {});

      RegisterActionCreator.checkName(_getStore());
      RegisterActionCreator.checkPhone(_getStore());
      RegisterActionCreator.checkEmail(_getStore());
      RegisterActionCreator.checkPosition(_getStore());
      RegisterActionCreator.checkCompanyId(_getStore());
    } else {
      controllerColor.reset();
      visible = false;
      //setState(() {});
    }
    print(visible);
    if (visible) {
      controllerColor.forward();
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //controller.dispose();
    controllerColor.dispose();
    super.dispose();
  }

  ///上传用户信息
  void uploadData() {
    print(visible);
    isVisible = true;
    print('用户信息 ${_userNameController.text.toString()}');

    if (_getStore().state.register.name != null) {
      if (_getStore().state.register.nameError) {
        tips = "请输入正确的姓名";
        initErrorTips();
        return;
      }
    }
    if (_getStore().state.register.phone != null) {
      if (_getStore().state.register.phoneError) {
        tips = "请输入正确的手机号";
        initErrorTips();
        return;
      }
    }
    if (_getStore().state.register.email != null) {
      if (_getStore().state.register.emailError) {
        tips = "请输入正确的邮箱";
        initErrorTips();
        return;
      }
    }
    if (_getStore().state.register.position != null) {
      if (_getStore().state.register.positionError) {
        tips = "请输入正确的职务";
        initErrorTips();
        return;
      }
    }
    if (_getStore().state.register.company_id != null) {
      if (_getStore().state.register.companyError) {
        tips = "请选择所属的公司";
        initErrorTips();
        return;
      }
    }

    RegisterActionCreator.register(_getStore());
  }

  ///错误提示
  void initErrorTips() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                color: Colors.transparent,
                alignment: Alignment.bottomCenter,
                child: new Container(
                  height: screen.setWidth(56),
                  alignment: Alignment.topCenter,
                  //transform: Matrix4.translationValues(0.0, animation.value, 0.0),
                  color: const Color(0xffDD412A),
                  child: new Padding(
                    padding:
                        new EdgeInsets.fromLTRB(0, screen.setWidth(10), 0, 0),
                    child: new Text(
                      tips,
                      style: TextStyle(
                          color: Colors.white, fontSize: screen.setSp(16)),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void initShowBottowSheet() {
    _focusNode.unfocus();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text(
                  "广州总部",
                  style: TextStyle(fontSize: screen.setSp(18)),
                ),
                onPressed: () {
                  companyName = "广州总部";
                  selectedValue("1");
                },
              ),
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text(
                  "北京分公司",
                  style: TextStyle(fontSize: screen.setSp(18)),
                ),
                onPressed: () {
                  companyName = "北京分公司";
                  selectedValue("2");
                },
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(15)),
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Text(
                    "沈阳分公司",
                    style: TextStyle(fontSize: screen.setSp(18)),
                  ),
                  onPressed: () {
                    companyName = "沈阳分公司";
                    selectedValue("3");
                  },
                ),
              ),
            ],
          );
        });
  }

  void selectedValue(String companyName) {
    Navigator.pop(context);
    RegisterActionCreator.changeCompanyId(_getStore(), companyName);
    cheakInput();
  }

  _onDidChange(store) {
    //print(store.state.register.isRegister);
    if (isVisible && store.state.register.isRegister != null) {
      isVisible = true;
      if (isVisible &&
          ModalRoute.of(context).isCurrent &&
          store.state.register.isRegister) {
        isVisible = false;
        //print("未注册3");
        tips = "该邮箱已被注册";
        initErrorTips();
      } else {
        isVisible = false;
        store.dispatch(new IsRegisterAction(false));
        //print("未注册2");
        //print("===register_pwd===");
        Navigator.of(context).pushNamed('/register_pwd');
      }
    }
  }
}
