import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  final iconName;
  final iconTitle;
  final textStyle;
  final bgColor;
  Items(this.iconName, this.iconTitle, {this.textStyle, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: this.bgColor != false
                ? BoxDecoration(shape: BoxShape.circle, color: Colors.black)
                : BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
                icon: this.iconName, color: Colors.white, onPressed: () {}),
          ),
          Text(
            '${this.iconTitle}',
            style: this.textStyle ??
                TextStyle(fontSize: 14, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
