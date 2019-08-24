import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
/* 页面引入
---------- */
import 'Mine/Mine.dart';
import 'Find/Find_page.dart';
import 'package:testapp/tool/router.dart'; //路由
import 'package:testapp/cloud/cloud_page.dart';
import 'package:testapp/Video/Video_page.dart';
import 'package:testapp/components/bottomMusicPlayer/bottomMusicPlayer.dart';
/* 调试用
-------- */
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
/* flutter 状态管理
------------------ */
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
/* redux
-------- */
import './tool/redux.dart';

void main() {
  debugPaintSizeEnabled = false;
  Store<int> store = new Store<int>(mainReducer, initialState: 0);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (RouteSettings settings) => generateRoute(settings),
        home: Tables(),
      ),
    );
  }
}

class Tables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DefaultTabController(
          initialIndex: 1,
          length: 4,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Builder(
                        builder: (context) => IconButton(
                          icon: new Icon(Icons.dehaze),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TabBar(
                          unselectedLabelColor: Colors.black26,
                          labelColor: Colors.black87,
                          indicatorColor: Colors.black,
                          indicatorWeight: 0.01,
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                          unselectedLabelStyle: TextStyle(fontSize: 15),
                          tabs: <Widget>[
                            Text('我的'),
                            Text('发现'),
                            Text('云村'),
                            Text('视频'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: TabBarView(
                        children: <Widget>[Mine(), Find(), Cloud(), Video()],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('header'.toUpperCase()),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            ListTile(
              title: Text(
                'AAAAAA',
                textAlign: TextAlign.right,
              ),
              trailing: Icon(
                Icons.message,
                color: Colors.black12,
                size: 25.0,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text(
                'AAAAAA',
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.message,
                color: Colors.black12,
                size: 25.0,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMusicPlayer(),
    );
  }
}
