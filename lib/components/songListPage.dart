import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/find/components/items.dart';

class SongListPage extends StatefulWidget {
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  String url;
  String imgUrl;
  String playCount;
  String songListTitle;
  String description;
  Map creator;
  List optionsIcon;
/* 获取歌单信息 */
  getSongListInto() async {
    var response = await http.get(this.url);
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['playlist'];
      String count = this.playCountHandler(res['playCount']);

      setState(() {
        this.imgUrl = res['coverImgUrl'];
        this.playCount = count;
        this.songListTitle = res['name'];
        this.creator = res['creator'];
        this.description = res['description'];
        //评论数和分享数
        this.optionsIcon = [
          {'icon': 0xe7bc, "title": res['commentCount']},
          {'icon': 0xe7bc, "title": res['shareCount']},
          {'icon': 0xe7bc, "title": res['下载']},
          {'icon': 0xe7bc, "title": res['多选']},
        ];
      });
    }
  }

  playCountHandler(int count) {
    double temp = count / 10000;
    return temp.floor().toString();
  }

  @override
  Widget build(BuildContext context) {
    this.url = ModalRoute.of(context).settings.arguments.toString();
    this.getSongListInto();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(this.imgUrl),
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 413,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 210),
                      child: Text(
                        '歌单',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.drag_handle,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 歌单图片
                    Container(
                      width: 150,
                      padding: EdgeInsets.only(left: 20),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(this.imgUrl),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                              Text(
                                '${this.playCount}万',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // 歌单标题
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  this.songListTitle,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  padding: EdgeInsets.only(right: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        this.creator['avatarUrl']),
                                  ),
                                ),
                                Text(
                                  '${this.creator['nickname']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white70,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        '${this.description}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white54,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    this.optionsIcon.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 20),
                          child: Items(
                              Icon(
                                IconData(this.optionsIcon[index]['icon'],
                                    fontFamily: 'iconfont'),
                              ),
                              '${this.optionsIcon[index]['title']}'),
                        ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*   */
