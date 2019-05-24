
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/actions/finishbook.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/views/detail_page/detail.dart';

/**
 * 已读书籍
 */
class FinishReadBooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FinishReadBooksState();
  }
}

class _FinishReadBooksState extends State<FinishReadBooks>  {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FinishBookActionCreator.getFinishBook(_getStore());
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {

      int size = _getStore().state.finishBook == null
          ? 0 : _getStore().state.finishBook.data == null
          ? 0 :_getStore().state.finishBook.data.length;
      if(size == 0){
        return getCenter();
      }
      return new ListView.builder(
          itemCount: _getStore().state.finishBook == null
              ? 0 : _getStore().state.finishBook.data == null
              ? 0 :_getStore().state.finishBook.data.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          });
    },
    );
  }

  Widget getCenter() {
    return new Center(
      child: new Text('暂无数据',style: TextStyle(color: Colors.black,fontSize: screen.setSp(20)),),
    );
  }

  Widget getRow(int position) {
    //return new ReadBookItem();
    return new GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new Detail(_getStore().state.finishBook.data[position].bookId),
          ),
        );
      },
      child: new Stack(
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
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: screen.setWidth(8),
                      spreadRadius: screen.setWidth(2)
                  )
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
                      _getStore().state.finishBook == null ? "" :
                      _getStore().state.finishBook.data == null ? "" :
                      _getStore().state.finishBook.data[position].bookName == null ? "" :
                      _getStore().state.finishBook.data[position].bookName,
                      style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: screen.setSp(15),
                          fontWeight: FontWeight.bold),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //作者
                  new Container(
                    margin: new EdgeInsets.only(left: screen.setWidth(65),top: screen.setWidth(8)),
                    child: new Text(
                      _getStore().state.finishBook == null ? "" :
                      _getStore().state.finishBook.data == null ? "" :
                      _getStore().state.finishBook.data[position].author == null ? "" :
                      _getStore().state.finishBook.data[position].author,
                      style: TextStyle(color: Color(0xFF303030),fontSize: screen.setSp(13)),),
                  ),
                  new Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(left: screen.setWidth(65),top: screen.setWidth(8)),
                        child: new Text(
                          _getStore().state.finishBook == null ? "" :
                          _getStore().state.finishBook.data == null ? "" :
                          _getStore().state.finishBook.data[position].startTime == null ? "" :
                          "借阅时间：" + new DateFormat('yyyy年MM月')
                              .format(_getStore().state.finishBook.data[position].startTime),
                          style: TextStyle(color: Color(0xFFBBBBBB),fontSize: screen.setSp(12)),),
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
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

}
