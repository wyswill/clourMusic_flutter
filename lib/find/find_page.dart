import 'dart:convert';
import 'package:banner/banner.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/find/components/items.dart';
import 'package:testapp/find/components/songListItem.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  List imageS = List();
  List songList = List();
  @override
  void initState() {
    super.initState();
    getBannerImages();
    getSongList();
  }

//获取banner图数据
  getBannerImages() async {
    String url = 'http://192.168.8.122:3000/banner?type=2';
    List serverDataList = List();
    var response = await http.get(url);
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic ele in responseJson['banners']) {
        serverDataList.add({
          "pic": ele['pic'],
          'typeTitle': ele['typeTitle'],
          "titleColor": this.bgColorHandler(ele['titleColor']),
        });
      }
      setState(() {
        imageS = serverDataList;
      });
    }
  }

  // 获取热门歌单
  getSongList() async {
    String url = 'http://192.168.8.122:3000/personalized?limit=9';
    List temp = List();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic ele in responseJson['result']) {
        String playCount = playCountHandler(ele['playCount']);
        temp.add({
          "picUrl": ele['picUrl'],
          'name': ele['name'],
          "playCount": playCount,
          "id": ele['id']
        });
      }
      setState(() {
        songList = temp;
      });
    }
  }

  //播放数量转
  playCountHandler(int count) {
    double temp = count / 10000;
    return temp.floor().toString();
  }

  //banner title 背景颜色处理
  bgColorHandler(String color) {
    MaterialColor res;
    switch (color) {
      case 'blue':
        res = Colors.blue;
        break;
      case 'red':
        res = Colors.red;
        break;
      default:
        res = Colors.blue;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            // banner图
            BannerView(
              height: 146,
              data: this.imageS,
              buildShowView: (index, data) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Stack(children: <Widget>[
                    Image.network(
                      data['pic'],
                      fit: BoxFit.fill,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50)),
                      ),
                      child: Text(
                        '${data['typeTitle']}',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: data['titleColor'],
                        ),
                      ),
                    ),
                  ]),
                );
              },
              onBannerClickListener: (index, data) {},
            ),
            //banner图下面的圆圈
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Items(Icon(Icons.event_note), '每日推荐'),
                    Items(Icon(Icons.music_video), '歌单'),
                    Items(
                        Icon(
                          IconData(0xe7bc, fontFamily: 'iconfont'),
                        ),
                        '排行榜'),
                    Items(
                        Icon(
                          IconData(0xe65b, fontFamily: 'iconfont'),
                        ),
                        '电台'),
                    Items(
                        Icon(
                          IconData(0xe6c2, fontFamily: 'iconfont'),
                        ),
                        '直播'),
                  ],
                ),
              ),
            ),
            //推荐歌单
            Container(
              child: Column(
                children: <Widget>[
                  // 标题
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '推荐歌单',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              '歌单广场',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // 歌单元素
                  Wrap(
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.end,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      this.songList.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            int musicId = this.songList[index]['id'];
                            Navigator.pushNamed(
                              context,
                              '/songList',
                              arguments: {
                                'url':
                                    'http://192.168.8.122:3000/playlist/detail?id=${musicId.toString()}'
                              },
                            );
                          },
                          child: SongListItem(
                            imageUrl: this.songList[index]['picUrl'],
                            imageTitle: this.songList[index]['name'],
                            playCount: this.songList[index]['playCount'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
