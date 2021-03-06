import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloudMusic_flutter/components/bottomMusicPlayer/bottomMusicPlayer.dart';
import 'package:cloudMusic_flutter/components/single_song.dart';
import 'package:cloudMusic_flutter/find/components/items.dart';

class SongListPage extends StatefulWidget {
  final arguments;
  SongListPage({Key key, this.arguments}) : super(key: key);
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  @override
  void initState() {
    super.initState();
    this.getSongListInto();
  }

  String imgUrl; //歌单图片
  String playCount; //播放数量
  String songListTitle; //歌单标题
  String description; //歌单描述
  Map creator; //歌单创建者
  List optionsIcon; //歌单图标
  int subscribedCount; //收藏数
  List songs;
  int songLength;
/* 获取歌单信息 */
  getSongListInto() async {
    var response = await http.get(widget.arguments['url']);
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['playlist'];
      String count = this.playCountHandler(res['playCount']);
      setState(() {
        this.imgUrl = res['coverImgUrl'];
        this.playCount = count;
        this.songListTitle = res['name'];
        this.creator = res['creator'];
        this.description = res['description'];
        this.subscribedCount = res['subscribedCount'];
        //评论数和分享数
        this.optionsIcon = [
          {'icon': 0xe628, "title": res['commentCount']},
          {'icon': 0xe620, "title": res['shareCount']},
          {'icon': 0xe612, "title": '下载'},
          {'icon': 0xe62e, "title": '多选'},
        ];
        // 歌曲
        this.songs = res['tracks'];
        this.songLength = res['tracks'].length;
      });
    }
  }

  playCountHandler(int count) {
    double temp = count / 10000;
    return temp.floor().toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('歌单'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(this.imgUrl ?? ''),
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 400,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                  Container(
//                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Container(
                        //       child: Row(
                        //         children: <Widget>[
                        //           IconButton(
                        //             icon: Icon(
                        //               Icons.arrow_back,
                        //               color: Colors.white,
                        //             ),
                        //             onPressed: () {
                        //               Navigator.pop(context);
                        //             },
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 10),
                        //             child: Text(
                        //               '歌单',
                        //               style: TextStyle(
                        //                   fontSize: 20, color: Colors.white),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       child: Row(
                        //         children: <Widget>[
                        //           IconButton(
                        //             icon: Icon(
                        //               Icons.search,
                        //               color: Colors.white,
                        //             ),
                        //             onPressed: () {},
                        //           ),
                        //           IconButton(
                        //             icon: Icon(
                        //               Icons.drag_handle,
                        //               color: Colors.white,
                        //             ),
                        //             onPressed: () {},
                        //           )
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 35),
                    child: Column(
                      children: <Widget>[
                        // 歌单图片和标题
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
                                    child: Image.network(this.imgUrl ?? ''),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '${this.playCount ?? 0}万',
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text(
                                          this.songListTitle != null
                                              ? this.songListTitle
                                              : '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 15,
                                        bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 30,
                                          padding: EdgeInsets.only(right: 5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                this.creator != null
                                                    ? this.creator['avatarUrl']
                                                    : ''),
                                          ),
                                        ),
                                        Text(
                                          '${this.creator != null ? this.creator['nickname'] : ''}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Wrap(
                                            children: <Widget>[
                                              Text(
                                                '${this.description != null ? this.description : ''}',
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
                        //icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (index) {
                            Map iconObj;
                            if (this.optionsIcon != null)
                              iconObj = this.optionsIcon[index];
                            else
                              iconObj = {'icon': 0xe7bc, "title": ''};
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 20),
                              child: Items(
                                Icon(
                                  IconData(iconObj['icon'] ?? '',
                                      fontFamily: 'iconfont'),
                                ),
                                iconObj['title'] ?? '',
                                textStyle: TextStyle(
                                  fontSize: 12,
                                ),
                                bgColor: false,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    constraints: BoxConstraints(
                      minHeight: 600,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.play_circle_filled),
                                    Text('播放全部',
                                        style: TextStyle(fontSize: 18)),
                                    Text('(共${this.songLength ?? 0})首',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add, color: Colors.white),
                                    Text('收藏',
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis),
                                    Text('(${this.subscribedCount ?? 0})',
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            this.songLength ?? 0,
                            (index) {
                              return GestureDetector(
                                child: SingleSong(
                                  index: index,
                                  ar: this.songs[index]['ar'],
                                  name: this.songs[index]['name'],
                                ),
                                onTap: () {
                                  print(this.songs[index]['id']);
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMusicPlayer(),
    );
  }
}
