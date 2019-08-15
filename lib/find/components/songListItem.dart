import 'package:flutter/material.dart';

class SongListItem extends StatelessWidget {
  String imageUrl;
  String imageTitle;
  String playCount;
  SongListItem({this.imageUrl, this.imageTitle, this.playCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.only(top: 15, right: 10),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(this.imageUrl),
                ),
                Text(
                  this.imageTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  '$playCount万',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
