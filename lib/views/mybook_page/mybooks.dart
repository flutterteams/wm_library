import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/views/mybook_page/bookappointment.dart';
import 'package:wm_library/views/mybook_page/finish_readbooks.dart';
import 'package:wm_library/views/mybook_page/readbooks.dart';



class MyBooks extends StatelessWidget {

  bool isOrder;
  MyBooks(this.isOrder);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new MyBooksHome(isOrder),
    );
  }
}

class MyBooksHome extends StatelessWidget {

  bool isOrder;
  MyBooksHome(this.isOrder);

  int isChoose = 0;

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      _renderTab(new Text(
        "在读书籍",
      )),
      _renderTab(new Text(
        "预约书籍",
      )),
      _renderTab(new Text(
        "已读书籍",
      ))
    ];

    Widget tabBarContainer = new TabBar(
      isScrollable: true, //这个属性是导航栏是否支持滚动，false则会挤在一起了
      unselectedLabelColor: Color(0xFFBBBBBB), //未选标签标签的颜色(这里定义为灰色)
      labelColor: Color(0xFF50BBD8), //选中的颜色
      labelStyle: TextStyle(fontSize: screen.setSp(16)),
      unselectedLabelStyle: TextStyle(fontSize: screen.setSp(15)),
      indicatorColor: Color(0xFF50BBD8), //指示器颜色
      indicatorWeight: 2.0, //指示器厚度
      indicatorPadding: EdgeInsets.only(left: 14, right: 14),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: myTabs,
      onTap: (index) {},
    );

    Widget tabContainer = new DefaultTabController(
      length: myTabs.length,
      initialIndex: isOrder ? isChoose=1 : isChoose, //初始索引
      child: new Column(
        children: <Widget>[
          _topBackWidget(context),
          new Container(
//            constraints: new BoxConstraints.expand(
//              height:
//              Theme.of(context).textTheme.display1.fontSize * 1.1 + 50.0,
//            ),
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            child: tabBarContainer,
          ),
          new Expanded(
            child: new TabBarView(children: [
              new ReadBooks(),
              new BooksAppointment(),
              new FinishReadBooks(),
            ]),
          ),
        ],
      ),
    );
    return tabContainer;
  }

  ///顶部返回部分
  _topBackWidget(BuildContext context) {
    return new Container(
      //margin: EdgeInsets.only(top: screen.setWidth(13)),
      padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setHeight(7)),
      color: Colors.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new IconButton(
            //padding: new EdgeInsets.only(left: 13 * unit2 ,top: 33 * unit2),
              padding: new EdgeInsets.only(left: screen.setWidth(13),top: screen.setHeight(37)),
              alignment: Alignment.centerLeft,
              icon: new Icon(Icons.arrow_back_ios),
              color: const Color(0xFF424242),
              iconSize: screen.setWidth(20),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          new Container(
            //height: screen.setWidth(33),
            alignment: Alignment.topLeft,
            padding: new EdgeInsets.fromLTRB(0, screen.setHeight(37), 0, 0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    print("点击返回我的书籍");
                  },
                  child: new Container(
                    child: new Text(
                      "我的书籍",
                      style: TextStyle(
                          color: Color(0xFF212121), fontSize: screen.setSp(17)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///返回一个标签
  _renderTab(text) {
    return new Tab(
        child: new Container(
      margin: new EdgeInsets.fromLTRB(
          screen.setWidth(10), 0, screen.setWidth(10), 0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[text],
      ),
    ));
  }
}

///暂时
class FinishReadBook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FinishReadBookState();
  }
}

class _FinishReadBookState extends State<FinishReadBook>
    with TickerProviderStateMixin {
  TabController _tabController;

  AnimationController _controller;
  Animation<double> rotate;
  Animation<double> rotate2;
  Animation<EdgeInsets> movement;
  Animation<double> height;
  Animation<double> width;

  var movements;

  int isChoose = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);

    _controller = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    rotate2 = Tween<double>(
      begin: 0.1,
      end: 0.0,
      //end: -math.pi ,
      //end: -math.pi ,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );

    rotate = Tween<double>(
      begin: 0.0,
      end: math.pi,
      //end: -math.pi ,
      //end: -math.pi ,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          0.4,
          curve: Curves.ease,
        ),
      ),
    );

    double moveWidth = screen.setWidth(220);

    movement = EdgeInsetsTween(
      begin: EdgeInsets.only(left: moveWidth),
      end: EdgeInsets.only(left: 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    height = Tween<double>(
      begin: 90.0,
      end: 90.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );

    width = Tween<double>(
      begin: 150.0,
      end: moveWidth,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          0.2,
          curve: Curves.ease,
        ),
      ),
    );

    //_startAnimation();
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(
      builder: (context, store) {
        return new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0),
              child: new FlatButton(
                  textColor: Colors.black,
                  child: new Text('replay staggered'),
                  onPressed: () {
                    //Navigator.of(context).pushNamed('/toptabs');
                    _startAnimation();
                    //_controller.reverse();
                  }),
            ),
            new AnimatedBuilder(animation: _controller, builder: _buildAni)
          ],
        );
      },
    );
  }

  Widget _buildAni(BuildContext context, Widget child) {
    return new Container(
      //color: Colors.black,
      //margin: new EdgeInsets.fromLTRB(screen.setWidth(10), screen.setWidth(10), 0, 0),
      padding: movement.value,
      //transform: Matrix4.identity()..rotateY(rotate.value),
      //transform: Matrix4.identity()..setEntry(2, 3, 0.006)..rotateY(rotate.value),
      //transform: Matrix4.rotationY(rotate.value),
      child: new Opacity(
        opacity: 1.0,
        child: Transform(
          alignment: Alignment.topRight,
          //transform: new Matrix4.skew(rotate2.value,0.0),
          //transform: new Matrix4.skewY(rotate2.value),
          //transform: Matrix4(math.tan(math.pi / 4), 0, math.tan(math.pi / 4), 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
          //transform: Matrix4.rotationZ(rotate.value),
          //transform: Matrix4.identity()..setEntry(2, 3, 0.006)..rotateY(rotate.value),
          transform: Matrix4.identity()..setEntry(2, 3, 0.006)..rotateY(math.sqrt(3) / 2 * screen.setWidth(375)),
          child: new Container(
            //width: width.value,
            //height: height.value,
            //width: 90,
            height: 90,
            decoration: new BoxDecoration(
                color: Colors.red,
                border: new Border.all(
                  color: Colors.red,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 4.0)
                ]),

            child: new Center(
              child: new Text(
                '测试三',
                style: new TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    print("----------");
    _controller.forward();
  }
}
