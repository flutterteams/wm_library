
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:wm_library/actions/appointmentbook.dart';
import 'package:wm_library/actions/cancelborrow.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/components/comment/tips_dialog.dart';
import 'package:wm_library/redux/app_reducer.dart';

///预约书籍
class BooksAppointment extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BooksAppointmentState();
  }
}

class _BooksAppointmentState extends State<BooksAppointment> {

  bool tag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    AppointmentBookActionCreator.getAppointmentBook(_getStore());
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }
  @override
  Widget build(BuildContext context) {

    return new StoreBuilder<AppState>(builder: (context, store) {

      int size = _getStore().state.appointmentBook == null
          ? 0 : _getStore().state.appointmentBook.data == null
          ? 0 :_getStore().state.appointmentBook.data.length;
      if(size == 0){
        return getCenter();
      }
      return new ListView.builder(
          itemCount: _getStore().state.appointmentBook == null
              ? 0 : _getStore().state.appointmentBook.data == null
              ? 0 :_getStore().state.appointmentBook.data.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          });
    },
        onDidChange: (store) {
          _onDidChange(store);
        }
    );
  }

  Widget getCenter() {
    return new Center(
      child: new Text('暂无数据',style: TextStyle(color: Colors.black,fontSize: screen.setSp(20)),),
    );
  }

  Widget getRow(int position) {
    //return new ReadBookItem();
    return new Stack(
      children: <Widget>[
        new Container(
          height: screen.setWidth(115),
          margin: new EdgeInsets.fromLTRB(screen.setWidth(51), position == 0 ? screen.setWidth(40) : screen.setWidth(28), screen.setWidth(16), 0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                color: Colors.white70,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                //卡片阴影
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 2.0)
              ]),

          child: new Container(
            margin: new EdgeInsets.only(top: screen.setWidth(10)),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //书名
                new Container(
                  margin: new EdgeInsets.only(left: screen.setWidth(65)),
                  child: new Text(
                    _getStore().state.appointmentBook == null ? "" :
                    _getStore().state.appointmentBook.data == null ? "" :
                    _getStore().state.appointmentBook.data[position].bookName == null ? "" :
                    _getStore().state.appointmentBook.data[position].bookName,
                    style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: screen.setSp(15),
                        fontWeight: FontWeight.bold,

                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //作者
                new Container(
                  margin: new EdgeInsets.only(left: screen.setWidth(65),top: screen.setWidth(8)),
                  child: new Text(
                    _getStore().state.appointmentBook == null ? "" :
                    _getStore().state.appointmentBook.data == null ? "" :
                    _getStore().state.appointmentBook.data[position].author == null ? "" :
                    _getStore().state.appointmentBook.data[position].author,
                    style: TextStyle(color: Color(0xFF303030),fontSize: screen.setSp(13)),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                new Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: screen.setWidth(65),top: screen.setWidth(14),bottom: screen.setWidth(17)),
                      child: new Text(
                        _getStore().state.appointmentBook == null ? "" :
                        _getStore().state.appointmentBook.data == null ? "" :
                        _getStore().state.appointmentBook.data[position].startTime == null ? "" :
                        "预约时间：" + new DateFormat('yyyy年MM月')
                            .format(_getStore().state.appointmentBook.data[position].startTime),
                        style: TextStyle(color: Color(0xFFBBBBBB),fontSize: screen.setSp(12)),),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: screen.setWidth(15),top: screen.setWidth(14),bottom: screen.setWidth(17)),
                      //alignment: Alignment.topLeft,
                      child: new GestureDetector(
                        onTap: (){
                          print('取消预约');
                          showCupDialog(_getStore().state.appointmentBook.data[position].id);
                        },
                        child: new Text('取消预约',
                          style: TextStyle(color: Color(0xFF50BBD8),
                            fontSize: screen.setSp(12),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        new Positioned(
          left: 16,
          top: position == 0 ? 24 : 12,
          bottom: 25,
          child: new FadeInImage.assetNetwork(
            placeholder: "images/mybg.jpeg", //预览图
            fit: BoxFit.fitWidth,
            image: "https://s2.ax1x.com/2019/05/10/E2jrr9.md.jpg",
            //image: "images/mybg.jpeg",
            width: screen.setWidth(90),
            height: screen.setWidth(112),
          ),
        ),

      ],
    );

  }

  void showCupDialog(int id) {
    var dialog = CupertinoAlertDialog(
      content: Text(
        "确定取消该书籍预约时间吗？",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消",style: TextStyle(color: Color(0xFF999999),fontSize: screen.setWidth(17)),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text("确定",style: TextStyle(color: Color(0xFF4990E2),fontSize: screen.setWidth(17)),),
          onPressed: () {
            tag = true;
            toCommit(id);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  ///取消预约
  void toCommit(int id) async {
    await CancelBorrowActionCreator.cancelBorrow(_getStore(),id);
  }

  void _onDidChange(Store<AppState> store) {

    if( tag && store.state.cancelBorrow.isCancelborrow != null ){
      Navigator.pop(context);
      if( ModalRoute.of(context).isCurrent && store.state.cancelBorrow.isCancelborrow ){
        tag = false;
        AppointmentBookActionCreator.getAppointmentBook(_getStore());
        store.dispatch(new IsCancelBorrowAction(false));
        toShowDialog(true);
      }else{
        tag = false;
        store.dispatch(new IsCancelBorrowAction(false));
        toShowDialog(false);
      }
    }
  }
  void toShowDialog(bool ok) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return new TipsDialog(
            icon: new Icon(
              ok == true ? Icons.check_circle_outline : Icons.highlight_off,
              size: 35,
              color: Colors.white,
            ),
            text: ok == true ? "取消预约成功" : "取消预约失败",
          );

        }
    );
    new Timer(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

}