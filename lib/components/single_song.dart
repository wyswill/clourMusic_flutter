import 'package:flutter/material.dart';

class SingleSong extends StatelessWidget {
  final index;
  final ar;
  final name;
  final arlenth;
  SingleSong({this.index, this.ar, this.name, this.arlenth});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 12,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              (this.index + 1).toString(),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('${this.name}'),
              ),
              Container(
                child: Row(
                  children: List.generate(int.parse(this.arlenth), (index) {
                    // print(this.ar[index]['name']);
                    return Text(
                      'asdfasdf',
                      style: TextStyle(fontSize: 10),
                    );
                  }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
