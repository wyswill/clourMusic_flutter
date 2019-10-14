import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloudMusic_flutter/find/components/items.dart';
import 'package:cloudMusic_flutter/mine/components/listItem.dart';

class Mine extends StatefulWidget {
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  List icons = [
    {"icon": 0xe65b, "title": '私人FM'},
    {"icon": 0xe7bc, "title": '最新电音'},
    {"icon": 0xe75e, "title": '私藏推荐'},
    {"icon": 0xe75e, "title": '因乐交友'},
    {"icon": 0xe84e, "title": '亲子频道'},
    {"icon": 0xe611, "title": '古典专区'},
    {"icon": 0xe608, "title": '跑步FM'},
    {"icon": 0xe60a, "title": '小冰电台'},
    {"icon": 0xe605, "title": '爵士电台'},
    {"icon": 0xec6d, "title": '驾驶模式'},
  ];
  List<Widget> listItem = List();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            /* 顶部按钮图标 */
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  icons.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Items(
                        Icon(IconData(this.icons[index]['icon'],
                            fontFamily: 'iconfont')),
                        '${this.icons[index]['title']}'),
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                flex: 1,
                child: ListView(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  children: <Widget>[
                    ListBody(
                      children: <Widget>[
                        ListItem(
                          icon: 0xe65b,
                          title: '本地音乐',
                          borderWidth: 1,
                        ),
                        ListItem(
                          icon: 0xe65b,
                          title: '最近播放',
                          borderWidth: 1,
                        ),
                        ListItem(
                          icon: 0xe65b,
                          title: '下载管理',
                          borderWidth: 1,
                        ),
                        ListItem(
                          icon: 0xe65b,
                          title: '我的电台',
                          borderWidth: 1,
                        ),
                        ListItem(
                          icon: 0xe65b,
                          title: '我的收藏',
                          borderWidth: 0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
