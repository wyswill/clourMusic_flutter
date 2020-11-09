/*
 * @LastEditors: wyswill
 * @Description: 登陆
 *  * @Date: 2020-11-09 13:55:56
 * @LastEditTime: 2020-11-09 15:56:08
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloudMusic/store/store.dart';
import 'package:flutter_cloudMusic/utile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  String phoneNum, pwd;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Request request;
  @override
  void initState() {
    super.initState();
    request = Request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 200, left: 50, right: 50),
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Icon(Icons.music_note, color: Colors.white),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: _unameController,
                        decoration: InputDecoration(
                          labelText: "手机号",
                          icon: Icon(Icons.phone, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.black),
                          errorStyle: TextStyle(color: Colors.white),
                          counterStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (v) {
                          return v.trim().length > 0 ? null : "手机号不能为空";
                        },
                        onSaved: (phone) {
                          setState(() {
                            phoneNum = phone;
                          });
                        },
                      ),
                      TextFormField(
                        controller: _pwdController,
                        decoration: InputDecoration(
                            labelText: "密码",
                            icon: Icon(Icons.lock, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.black),
                            errorStyle: TextStyle(color: Colors.white)),
                        obscureText: true,
                        //校验密码
                        validator: (v) {
                          return v.trim().length > 5 ? null : "密码不能少于6位";
                        },
                        onSaved: (pd) {
                          setState(() {
                            pwd = pd;
                          });
                        },
                      ),
                    ],
                  )),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width - 100,
                color: Colors.white,
                child: Text('立即登陆', style: TextStyle(color: Colors.red)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                highlightColor: Color.fromRGBO(231, 192, 190, 1),
                onPressed: () => loginAction(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginAction(context) async {
    if ((_formKey.currentState.validate())) {
      _formKey.currentState.save();
      Response res = await request.dio
          .get('/login/cellphone?phone=$phoneNum&password=$pwd');

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<Store>(context, listen: false).cookie = res.data['cookie'];
        Provider.of<Store>(context, listen: false).posonnalInfo = res.data;
        prefs.setString('cookie', res.data['cookie']);
        Navigator.pushNamedAndRemoveUntil(context, '/find', (route) => false);
      }
    }
  }
}
