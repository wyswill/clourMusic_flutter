import 'package:flutter/material.dart';

class SingleSong extends StatelessWidget {
  final index;
  final ar;
  final name;
  SingleSong({
    this.index,
    this.ar,
    this.name,
  });
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
          Container(
            constraints: BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: List.generate(
                    this.ar.length > 3 ? 3 : this.ar.length,
                    (index) {
                      return Text(
                        this.ar[index]['name'] + ' - ',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
