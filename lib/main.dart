import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info/device_info.dart';
import 'package:wm_library/redux/store.dart';
import 'package:wm_library/routers/router.dart';

import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/login_page/login_input.dart';
import 'package:wm_library/views/login_page/login_success.dart';
import 'package:wm_library/views/register_page/register.dart';
import 'package:wm_library/views/index_page/index.dart';
import 'package:wm_library/views/comment_page/add.dart';

import 'components/comment/tips_dialog.dart';

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

  String _connectionStatus = 'Unknown';
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        //ConnectivityResult.wifi
        //ConnectivityResult.mobile
        //ConnectivityResult.none
        _connectionStatus = result.toString();
        print("监听网络："+_connectionStatus);
        if(_connectionStatus.contains("none") || _connectionStatus.contains("Unknown")){
          toShowDialog();
        }
      });
    }catch(e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {

    // 设置初始化尺寸
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    //ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    //ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

//    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
//    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
//    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
//    print('底部安全区距离:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
//    print('状态栏高度:${ScreenUtil.statusBarHeight}px'); //Status bar height , Notch will be higher Unit px
//
//    print('实际宽度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleWidth}');
//    print('实际高度的dp与设计稿px的比例:${ScreenUtil.getInstance().scaleHeight}');
//
//    print(
//        '宽度和字体相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleWidth * ScreenUtil.pixelRatio}');
//    print('高度相对于设计稿放大的比例:${ScreenUtil.getInstance().scaleHeight * ScreenUtil.pixelRatio}');
//    print('系统的字体缩放比例:${ScreenUtil.textScaleFactory}');

    return new Index();
  }

  void toShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return new TipsDialog(
            icon: new Icon(
              Icons.highlight_off,
              size: 35,
              color: Colors.white,
            ),
            text:  "网络连接异常！",
          );
        });
    new Timer(new Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
