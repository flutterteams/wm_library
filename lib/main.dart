import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wm_library/redux/store.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/routers/router.dart';

import 'package:wm_library/actions/login.dart';
import 'package:wm_library/views/register_page/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = createStore();

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MyHomePage(title: 'Flutter Demo Home Page'),
          routes: new Routers().router.length == 0 ? {} : new Routers().router,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // 设置初始化尺寸
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);

    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Text(
                    '登录',
                    style: new TextStyle(
                        fontSize: ScreenUtil().setSp(28)
                    ),
                  ),
                  width: ScreenUtil().setWidth(360),
                  color: Colors.red,
                )
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () => {LoginActionCreator.login(store)},
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ));
    });
  }
}
