
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/redux/app_reducer.dart';


class RegisterPwd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPwdState();
  }
}

class _RegisterPwdState extends State<RegisterPwd> {

  bool visible = false;

  TextEditingController _userPwdController = new TextEditingController();
  TextEditingController _userRepeatPwdController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Scaffold(
        //appBar: AppBar(),
        body: new Opacity(
          opacity: 0.5,
          child: new Container(
            color: Colors.black87,
            child: new ListView(
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left:15.0,),
                      child: new IconButton(
                          icon: new Image.asset('images/back_normal.png') ,
                          onPressed: (){
                            print('返回注册页');
                            Navigator.pop(context);
                          }),
                    ),

                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top:65.0,bottom: 30.0),
                      child: new Image.asset('images/back_normal.png',
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:30.0,),
                      child: new TextField(
                        controller: _userPwdController,
                        keyboardType: TextInputType.numberWithOptions(),
                        textAlign: TextAlign.center,
                        maxLength: 8,
                        obscureText: true,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '密码？',
                          hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,bottom: 100.0),
                      child: new TextField(
                        controller: _userRepeatPwdController,
                        keyboardType: TextInputType.numberWithOptions(),
                        textAlign: TextAlign.center,
                        maxLength: 8,
                        obscureText: true,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '确认密码？',
                            hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:35.0,),
                      child: new Opacity(
                          opacity: visible ? 1.0 : 0.2,
                          child: new IconButton(
                              icon: new Image.asset('images/back_normal.png') ,
                              onPressed: (){
                                if(visible){
                                  print('点击了跳转登录');
                                }
                              }),
                          //new Image.asset('images/back_normal.png'),
                      ),

                    ),

                  ],
                ),
              ],
            )
          ),
        ),
      );

    });
  }

  void cheakData(String value) {
    if(_userPwdController.text.isNotEmpty && _userRepeatPwdController.text.isNotEmpty
        && _userPwdController.text == _userRepeatPwdController.text){
      visible = true;
      setState(() {
      });
    }else{
      visible = false;
      setState(() {
      });
    }
  }

}