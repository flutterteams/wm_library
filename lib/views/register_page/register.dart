
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/redux/app_reducer.dart';
import 'package:wm_library/views/login_page/login.dart';
import 'package:wm_library/views/register_page/registerpwd.dart';


class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

  bool visible = false;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _postController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();

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
                            print('返回登录页');
                            Navigator.pop(context);
                          }),
                    ),

                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top:65.0,),
                      child: new Image.asset('images/back_normal.png',
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,),
                      child: new TextField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        maxLength: 10,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '真实姓名？',
                          hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,),
                      child: new TextField(
                        controller: _phonenumberController,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        maxLength: 11,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '手机号？',
                            hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),


                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,),
                      child: new TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '邮箱？',
                            hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,),
                      child: new TextField(
                        controller: _postController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        maxLength: 10,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '职务？',
                            hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:28.0,),
                      child: new TextField(
                        controller: _companyController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        maxLength: 20,
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                            border: InputBorder.none,
                            hintText: '所属公司？',
                            hintStyle: new TextStyle(color: Colors.blue,fontSize: 16.0)
                        ),
                        onChanged: (value){
                          cheakData(value);
                        },
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top:55.0,),
                      child: new Opacity(
                          opacity: visible ? 1.0 : 0.2,
                          child: new IconButton(
                              icon: new Image.asset('images/back_normal.png') ,
                              onPressed: (){
                                if(visible){
                                  print('点击了');
                                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                                    return new RegisterPwd();
                                  }));
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
    if(_userNameController.text.isNotEmpty && _phonenumberController.text.isNotEmpty
        && _emailController.text.isNotEmpty && _postController.text.isNotEmpty
        && _companyController.text.isNotEmpty){
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