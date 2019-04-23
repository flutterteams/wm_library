import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wm_library/redux/store.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/routers/router.dart';

import 'package:wm_library/actions/login.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  store.state.login.name == null ? '' : store.state.login.name,
                ),
                new Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
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
