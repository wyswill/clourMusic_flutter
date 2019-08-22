import 'package:testapp/components/songListPage.dart';

import 'Mine/Mine.dart';
import 'Find/Find_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testapp/cloud/cloud_page.dart';
import 'package:testapp/Video/Video_page.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = {
    "/songList": (context, {arguments}) => SongListPage(arguments: arguments),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Tables(),
        onGenerateRoute: (RouteSettings settings) {
          // 统一处理
          final String name = settings.name;
          final Function pageContentBuilder = this.routes[name];
          if (pageContentBuilder != null) {
            if (settings.arguments != null) {
              final Route route = MaterialPageRoute(
                  builder: (context) => pageContentBuilder(context,
                      arguments: settings.arguments));
              return route;
            } else {
              final Route route = MaterialPageRoute(
                  builder: (context) => pageContentBuilder(context));
              return route;
            }
          }
        });
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
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
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
    );
  }
}
