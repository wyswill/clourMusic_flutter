/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-06 11:52:40
 * @LastEditTime: 2020-11-06 11:53:15
 */
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('video'),
      ),
    );
  }
}
