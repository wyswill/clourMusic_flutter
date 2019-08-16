import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final icon;
  final borderWidth;
  final title;
  ListItem({this.icon, this.title, this.borderWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Icon(
              IconData(this.icon, fontFamily: 'iconfont'),
              size: 35,
            ),
          ),
          Expanded(
            child: Container(
              decoration: this.borderWidth == 0
                  ? BoxDecoration()
                  : BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: this.borderWidth, color: Colors.grey),
                      ),
                    ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text('${this.title}'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
