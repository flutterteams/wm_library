
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library/actions/personal_info.dart';
import 'package:wm_library/common/global_variable.dart';
import 'package:redux/redux.dart';
import 'package:wm_library/redux/app_reducer.dart';

///个人信息详情页

class PersonalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new PersonalInformationHome(),
    );
  }
}

class PersonalInformationHome extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalInformationHomeState();
  }
}

class _PersonalInformationHomeState extends State<PersonalInformationHome> with TickerProviderStateMixin{


  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _signController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _positionController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();


  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  bool autofocus = false;
  String companyName = "";
  String position = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 监听签名焦点
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        PersonalInfoActionCreator.UpdatePersonalInfo(_getStore());
      }
    });

    // 监听职务焦点
    _focusNode2.addListener(() {
      if (!_focusNode.hasFocus ) {
        if(autofocus && position.isEmpty){
          showCptDialog();
          autofocus = false;
        }else{
          if(position.isNotEmpty) {
            PersonalInfoActionCreator.UpdatePersonalInfo(_getStore());
            autofocus = false;
          }
        }
      }
    });
  }
  /// Dialog
  void showCptDialog() {
    var dialog = CupertinoAlertDialog(
      content: Text(
        "职务信息不能为空！",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("知道了",style: TextStyle(color: Color(0xFF4990E2),fontSize: screen.setWidth(17)),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }



  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {

    return new StoreBuilder<AppState>(builder: (context, store) {
      return new Stack(
        children: <Widget>[
          new Container(
            height: screen.setWidth(33),
            alignment: Alignment.topLeft,
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(20), 0, 0),
            child: new IconButton(
                highlightColor: Colors.transparent,
                disabledColor: Colors.transparent,
                padding: new EdgeInsets.all(screen.setWidth(13)),
                alignment: Alignment.topLeft,
                icon: new Icon(Icons.arrow_back_ios),
                color: const Color(0xffbbbbbb),
                iconSize: screen.setWidth(23),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),

          new Container(
            margin: new EdgeInsets.fromLTRB(screen.setWidth(27), screen.setWidth(107), 0, 0),
            child: new Text(
              "个人资料",
              style: TextStyle(color: Colors.white, fontSize: screen.setSp(30)),
            ),
          ),

          new Container(
            margin: new EdgeInsets.fromLTRB(
                0, screen.setWidth(177), 0, 0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(89), 0),
                      child: new Opacity(
                        opacity: 0.45,
                        child: new Text(
                          "姓名",
                          style: TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Opacity(
                          opacity: 0.6,
                        child: new TextField(
                          //controller: _userNameController,
                          controller: TextEditingController.fromValue(TextEditingValue(
                              text: _getStore().state.userInfo == null ? "" : _getStore().state.userInfo.data == null ? "" : _getStore().state.userInfo.data.name == null ? "" : _getStore().state.userInfo.data.name,
//                              selection: TextSelection.fromPosition(TextPosition(
//                                  affinity: TextAffinity.downstream,
//                                  offset: companyName.length))
                          )),
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          enabled: false,
                          style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: '姓名',
                              hintStyle: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: screen.setSp(16))),
                          onChanged: (valueEmail) {
                            //RegisterActionCreator.changeEmail(store, valueEmail);
                            //cheakInput();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(30), 0, 0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(89), 0),
                        child: new Opacity(
                          opacity: 0.45,
                          child: new Text(
                            "签名",
                            style: TextStyle(color: Colors.white, fontSize: screen.setSp(15)),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new TextField(
                          //controller: _signController,
                          controller: TextEditingController.fromValue(TextEditingValue(
                            text: _getStore().state.userInfo == null ? "" : _getStore().state.userInfo.data == null ? "" : _getStore().state.userInfo.data.signature == null ? "" : _getStore().state.userInfo.data.signature,
                              selection: TextSelection.fromPosition(TextPosition(
                                  affinity: TextAffinity.downstream,
                                  offset: _getStore().state.userInfo == null ? 0 :
                                  _getStore().state.userInfo.data == null ? 0 :
                                  _getStore().state.userInfo.data.signature == null ? 0 :
                                  _getStore().state.userInfo.data.signature.length
                              )
                              )
                          )),
                          keyboardType: TextInputType.text,
                          //textAlign: TextAlign.start,
                          maxLength: 16,
                          style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                          focusNode: _focusNode,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              counterText: "",
                              hintText: '未填写',
                              hintStyle: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: screen.setSp(16))),
                          onChanged: (valueSign) {
                            PersonalInfoActionCreator.changeSign(store, valueSign);
                            cheakInput();
                          },
                        ),
                      ),

                    ],
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(30), 0, 0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(73), 0),
                        child: new Opacity(
                          opacity: 0.45,
                          child: new Text(
                            "手机号",
                            style: TextStyle(color: Colors.white, fontSize: screen.setSp(15)),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new Opacity(
                            opacity: 0.6,
                          child: new TextField(
                            //controller: _phoneController,
                            controller: TextEditingController.fromValue(TextEditingValue(
                                text: _getStore().state.userInfo == null ? "" : _getStore().state.userInfo.data == null ? "" :_getStore().state.userInfo.data.phone == null ? "" : _getStore().state.userInfo.data.phone,
//                                selection: TextSelection.fromPosition(TextPosition(
//                                    affinity: TextAffinity.downstream,
//                                    offset: _getStore().state.userInfo.data.phone.length))
                            )),
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.start,
                            enabled: false,
                            style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                            decoration: new InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none,
                                hintText: '手机号',
                                hintStyle: new TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: screen.setSp(16))),
                            onChanged: (valueEmail) {
                              //RegisterActionCreator.changeEmail(store, valueEmail);
                              //cheakInput();
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),


                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(30), 0, 0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(89), 0),
                        child: new Opacity(
                          opacity: 0.45,
                          child: new Text(
                            "邮箱",
                            style: TextStyle(color: Colors.white, fontSize: screen.setSp(15)),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new Opacity(
                            opacity: 0.6,
                          child: new TextField(
                            //controller: _emailController,
                            controller: TextEditingController.fromValue(TextEditingValue(
                                text: _getStore().state.userInfo == null ? "" : _getStore().state.userInfo.data == null ? "" :_getStore().state.userInfo.data.email == null ? "" : _getStore().state.userInfo.data.email,
//                                selection: TextSelection.fromPosition(TextPosition(
//                                    affinity: TextAffinity.downstream,
//                                    offset: _getStore().state.userInfo.data.email.length))
                            )),
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start,
                            enabled: false,
                            style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                            decoration: new InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: '邮箱',
                                hintStyle: new TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: screen.setSp(16))),
                            onChanged: (valueEmail) {
                              //RegisterActionCreator.changeEmail(store, valueEmail);
                              //cheakInput();
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(30), 0, 0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(89), 0),
                        child: new Opacity(
                          opacity: 0.45,
                          child: new Text(
                            "职务",
                            style: TextStyle(color: Colors.white, fontSize: screen.setSp(15)),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new TextField(
                          //controller: _positionController,
                          controller: TextEditingController.fromValue(TextEditingValue(
                              text: _getStore().state.userInfo == null ? "" : _getStore().state.userInfo.data == null ? "" :_getStore().state.userInfo.data.position == null ? "" : _getStore().state.userInfo.data.position,
                              selection: TextSelection.fromPosition(TextPosition(
                                  affinity: TextAffinity.downstream,
                                  offset: _getStore().state.userInfo == null ? 0 : _getStore().state.userInfo.data == null ? 0 :_getStore().state.userInfo.data.position == null ? 0 :_getStore().state.userInfo.data.position.length))
                          )),
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          maxLength: 10,
                          style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                          focusNode: _focusNode2,
                          //autofocus: autofocus,
                          inputFormatters: [
                            //WhitelistingTextInputFormatter(RegExp("^[\u4e00-\u9fa5a-zA-Z]+\$")),
                            WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5a-zA-Z]")),
                          ],
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              counterText: "",
                              hintText: '职务',
                              hintStyle: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: screen.setSp(16))),
                          onChanged: (valueposition) {
                            position = valueposition;
                            autofocus = true;
                            PersonalInfoActionCreator.changePosition(store, valueposition);
                            cheakInput();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                new Container(
                  margin: new EdgeInsets.fromLTRB(0, screen.setWidth(30), 0, 0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(screen.setWidth(27), 0, screen.setWidth(42), 0),
                        child: new Opacity(
                          opacity: 0.45,
                          child: new Text(
                            "所属分公司",
                            style: TextStyle(color: Colors.white, fontSize: screen.setSp(15)),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new GestureDetector(
                          onTap: (){
                            initShowBottowSheet();
                          },
                          child: new Text(
                              _getStore().state.userInfo == null ? "" :
                              _getStore().state.userInfo.data == null ? "" :
                              _getStore().state.userInfo.data.company_id == null ? "" :
                              _getStore().state.userInfo.data.company_id == 1 ? "广州总部":
                              _getStore().state.userInfo.data.company_id == 2 ? "北京分公司":
                              _getStore().state.userInfo.data.company_id == 3 ? "沈阳分公司" : "",
                            style: new TextStyle(color: Colors.white, fontSize: screen.setSp(16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
    );
  }


  void cheakInput() {

    PersonalInfoActionCreator.checkSign(_getStore());
    PersonalInfoActionCreator.checkPosition(_getStore());
    PersonalInfoActionCreator.checkCompanyId(_getStore());
//    setState(() {
//
//    });
  }

  void initShowBottowSheet() {
    _focusNode.unfocus();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text("广州总部",style: TextStyle(fontSize: screen.setSp(18)),),
                onPressed: (){
                  companyName = "广州总部";
                  selectedValue(1);
                },
              ),
              new FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: new Text("北京分公司",style: TextStyle(fontSize: screen.setSp(18)),),
                onPressed: (){
                  companyName = "北京分公司";
                  selectedValue(2);
                },
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, screen.setWidth(15)),
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Text("沈阳分公司",style: TextStyle(fontSize: screen.setSp(18)),),
                  onPressed: (){
                    companyName = "沈阳分公司";
                    selectedValue(3);
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  void selectedValue(int companyName) {
    Navigator.pop(context);
    PersonalInfoActionCreator.changeCompanyId(_getStore(), companyName );
    cheakInput();
    PersonalInfoActionCreator.UpdatePersonalInfo(_getStore());

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}