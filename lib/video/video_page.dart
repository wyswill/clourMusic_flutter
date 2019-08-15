import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('视频'),
    );
  }
}
