/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-06 11:56:07
 * @LastEditTime: 2020-11-06 11:56:38
 */
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('data'),
      ),
    );
  }
}
