import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  Icon iconName;
  String iconTitle;
  TextStyle textStyle;
  Items(this.iconName, this.iconTitle, {this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: IconButton(
                icon: this.iconName, color: Colors.white, onPressed: () {}),
          ),
          Text(
            '${this.iconTitle}',
            style: TextStyle(fontSize: 14, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
