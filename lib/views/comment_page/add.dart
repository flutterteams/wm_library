import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:wm_library/actions/comment.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:wm_library/redux/app_reducer.dart';

import 'package:wm_library/model/review/review.dart';

class AddComment extends StatelessWidget {
  int id;

  AddComment(this.id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new AddCommentHome(id),
    );
  }
}

class AddCommentHome extends StatefulWidget {
  int id;

  AddCommentHome(this.id);

  @override
  _AddCommentHomeState createState() => _AddCommentHomeState();
}

class _AddCommentHomeState extends State<AddCommentHome> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
        body: new Container(
          color: Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: screen.setWidth(26)),
                    width: double.infinity,
                    height: screen.setWidth(62),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                          blurRadius: screen.setWidth(2),
                          spreadRadius: screen.setWidth(1))
                    ]),
                    child: new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Positioned(
                          child: new IconButton(
                              icon: new Icon(
                                Icons.close,
                                color: Color(0xff424242),
                                size: screen.setWidth(24),
                              ),
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          top: screen.setWidth(-4),
                          left: screen.setWidth(-4),
                        ),
                        new Text(
                          '书籍评论',
                          style: new TextStyle(
                              fontSize: screen.setSp(17),
                              color: Color(0xff333333)),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: screen.setWidth(18)),
                    child: new TextField(
                      controller: controller,
                      maxLines: 2,
                      maxLength: 30,
                      enabled: true,
                      autofocus: true,
                      keyboardAppearance: Brightness.light,
                      cursorColor: Color(0xff426bf2),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(
                              screen.setWidth(16),
                              screen.setWidth(0),
                              screen.setWidth(16),
                              screen.setWidth(16)),
                          hintText: '限30字',
                          hintStyle: new TextStyle(
                              fontSize: screen.setSp(15),
                              color: const Color(0xffbbbbbb),
                              height: 1),
                          focusedBorder: InputBorder.none,
                          counterText: '',
                          enabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  )
                ],
              ),
              new GestureDetector(
                onTap: () {
                  CommentActionCreator.saveValue(
                      store, widget.id, controller.text, () {
                    Navigator.of(context).pop();
                  });
                },
                child: new Container(
                  width: double.infinity,
                  height: screen.setWidth(44),
                  color: Color(0xff50bbd8),
                  child: new Icon(
                    Icons.send,
                    size: screen.setWidth(24),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
