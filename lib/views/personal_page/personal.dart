import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/redux/app_reducer.dart';

class Personal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new PersonalHome(),
    );
  }
}

class PersonalHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalHomeState();
  }
}

class _PersonalHomeState extends State<PersonalHome>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadRefresh();
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    PersonalInfoActionCreator.PersonalInfo(_getStore());
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(
      builder: (context, store) {
        return new Stack(
          children: <Widget>[
            new Container(
              height: screen.setWidth(33),
              alignment: Alignment.topLeft,
              margin: new EdgeInsets.fromLTRB(0, screen.setWidth(20), 0, 0),
              child: new IconButton(
                  highlightColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  padding: new EdgeInsets.all(screen.setWidth(13)),
                  alignment: Alignment.topLeft,
                  icon: new Icon(Icons.close),
                  color: const Color(0xffbbbbbb),
                  iconSize: screen.setWidth(23),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, screen.setWidth(108), 0, 0),
              child: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(20)),
                      child: new GestureDetector(
                        onTap: () {
                          print("点击头像");
                        },
                        child: new ClipOval(
                          child: new FadeInImage.assetNetwork(
                            placeholder: "images/timg.jpg", //预览图
                            fit: BoxFit.fitWidth,
                            image:
                            "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3463668003,3398677327&fm=58",
                            width: 80.0,
                            height: 80.0,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(15)),
                      child: new Text(
                        _getStore().state.userInfo == null
                            ? "暂无"
                            : _getStore().state.userInfo.data == null
                            ? "暂无"
                            : _getStore().state.userInfo.data.name == null
                            ? "暂无"
                            : store.state.userInfo.data.name,
                        style: TextStyle(
                            color: Colors.white, fontSize: screen.setSp(24)),
                      ),
                    ),
                    new Container(
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(47)),
                      child: new Opacity(
                        opacity: 0.8,
                        child: new Text(
                          _getStore().state.userInfo == null
                              ? "未填写"
                              : _getStore().state.userInfo.data == null
                              ? "未填写"
                              : _getStore().state.userInfo.data.signature ==
                              null
                              ? "未填写"
                              : store.state.userInfo.data.signature,
                          style: TextStyle(
                              color: Colors.white, fontSize: screen.setSp(14)),
                        ),
                      ),
                    ),
                    new Container(
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(32)),
                      child: new GestureDetector(
                        onTap: () {
                          print("个人资料");
                          Navigator.of(context).pushNamed('/PersonalInformation');
                        },
                        child: new Opacity(
                          opacity: 0.8,
                          child: new Text(
                            "个人资料",
                            style: TextStyle(
                                color: Colors.white, fontSize: screen.setSp(20)),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(170)),
                      child: new GestureDetector(
                        onTap: () {
                          print("我的书籍");
                          Navigator.of(context).pushNamed('/mybooks');
                        },
                        child: new Opacity(
                          opacity: 0.8,
                          child: new Text(
                            "我的书籍",
                            style: TextStyle(
                                color: Colors.white, fontSize: screen.setSp(20)),
                          ),
                        ),
                      ),
                    ),
                    new Opacity(
                      opacity: 0.35,
                      child: new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(20), 0,
                            screen.setWidth(20), screen.setWidth(20)),
                        height: screen.setWidth(1),
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                    new Container(
                      margin:
                      new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(170)),
                      child: new GestureDetector(
                        onTap: () {
                          initShowBottowSheet();
                        },
                        child: new Opacity(
                          opacity: 0.8,
                          child: new Text(
                            "退出登录",
                            style: TextStyle(
                                color: Colors.white, fontSize: screen.setSp(18)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        );
      },
    );
  }

  void initShowBottowSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            color: Colors.black,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  //height: screen.setWidth(120),
                  margin: EdgeInsets.only(
                      left: screen.setWidth(10), right: screen.setWidth(10)),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: screen.setWidth(14),
                          bottom: screen.setWidth(14),
                        ),
                        child: new Text(
                          '确定退出当前账号吗？',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: screen.setSp(14),
                            letterSpacing: 0.11,
                            wordSpacing: 0.11,
                          ),
                        ),
                      ),
                      new Opacity(
                        opacity: 0.13,
                        child: new Divider(
                          height: screen.setWidth(1),
                          color: Color(0xFF09141F),
                        ),
                      ),
                      new GestureDetector(
                        onTap: () {
                          print('点击退出当前账号');
                          Navigator.pop(context);
                          //Navigator.of(context).pushNamed('/login');
                          print('==3333==');
                          //清除跳转外的所有路由
                          Navigator.of(context).pushNamedAndRemoveUntil('/login',
                                  (Route<dynamic> route) => false);
                        },
                        child: new Padding(
                          padding: EdgeInsets.only(
                              top: screen.setWidth(20),
                              bottom: screen.setWidth(18)),
                          child: new Text(
                            '退出',
                            style: TextStyle(
                              color: Color(0xFFD53A23),
                              fontSize: screen.setSp(20),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(
                      left: screen.setWidth(10),
                      top: screen.setWidth(10),
                      right: screen.setWidth(10),
                      bottom: screen.setWidth(15)),
                  height: screen.setWidth(56),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: new Center(
                    child: new Text(
                      '取消',
                      style: TextStyle(
                        color: Color(0xFF4990E2),
                        fontSize: screen.setWidth(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
