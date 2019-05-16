import 'package:flutter/material.dart';
import 'package:wm_library/common/global_variable.dart';

/**
 * 自定义dialog
 */
class TipsDialog extends Dialog {
  Icon icon;
  String text;

  TipsDialog({Key key, @required this.icon,@required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new Center(//保证控件居中效果
          child: new SizedBox(
            width: 153.0,
            height: 115.0,
            child: new Container(
              //color: Color(0xF0333333),
              decoration: new BoxDecoration(
                color: Color(0xF0333333),
                border: new Border.all(
                  color: Color(0xF0333333),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      margin:  EdgeInsets.fromLTRB(0,screen.setWidth(20),0,0),
                    child: icon,
                  ),
                  new Container(
                    margin:  EdgeInsets.only(top: screen.setWidth(10),bottom: screen.setWidth(20)),
                    child: new Text(
                      text,
                      style: new TextStyle(color:Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal, fontSize: screen.setWidth(14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}