import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:wm_library/actions/detail.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/views/comment_page/comment.dart';

class Order extends StatelessWidget {
  int id;

  Order(this.id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new OrderHome(id),
    );
  }
}

class OrderHome extends StatefulWidget {
  int id;

  OrderHome(this.id);

  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    DetailActionCreator.getData(_getStore(), widget.id);
//    DetailActionCreator.getReviewList(_getStore(), widget.id);
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
        body: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Column(
            children: <Widget>[
              new Container(
                height: screen.setWidth(33),
                child: new IconButton(
                    padding: new EdgeInsets.all(screen.setWidth(13)),
                    alignment: Alignment.topLeft,
                    icon: new Icon(Icons.arrow_back_ios),
                    color: Color(0xff424242),
                    iconSize: screen.setWidth(20),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                alignment: Alignment.topLeft,
                margin: new EdgeInsets.fromLTRB(
                    0, screen.setWidth(20), 0, screen.setWidth(27)),
              ),
              store.state.detail['book'] == null
                  ? new Container()
                  : new OrderMain()
            ],
          ),
        ),
      );
    });
  }
}

class OrderMain extends StatefulWidget {
  @override
  _OrderMainState createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store)
    {
      return new Container(
        padding:EdgeInsets.fromLTRB(screen.setWidth(28), 0, screen.setWidth(28), 0),
        child: new Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: screen.setWidth(32)),
              child: new Text('预约图书',style: new TextStyle(
                  fontSize: screen.setSp(30),
                  color: Color(0xff212121)
              ),),
            ),
            new Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(160.0),
                1: FixedColumnWidth(160.0),
              },
              border: TableBorder.all(color: Colors.red, width: 1.0, style: BorderStyle.solid),
              children: const <TableRow>[
                TableRow(
                  children: <Widget>[
                    Text('A1'),
                    Text('B1'),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Text('A2'),
                    Text('B2'),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Text('A3'),
                    Text('B3'),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

