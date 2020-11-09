/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-06 10:57:54
 * @LastEditTime: 2020-11-09 15:58:03
 */
import 'package:flutter/material.dart';
import 'package:flutter_cloudMusic/pages/account.dart';
import 'package:flutter_cloudMusic/pages/cloudVilige.dart';
import 'package:flutter_cloudMusic/pages/find.dart';
import 'package:flutter_cloudMusic/pages/login.dart';
import 'package:flutter_cloudMusic/pages/mine.dart';
import 'package:flutter_cloudMusic/pages/video.dart';
import 'package:flutter_cloudMusic/router.dart';
import 'package:flutter_cloudMusic/store/store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Store()),
      ],
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int currentIndex = 0;
  Future<String> cookiedb;
  @override
  void initState() {
    super.initState();
    cookiedb = _prefs.then((SharedPreferences spf) => spf.getString('cookie'));
    cookiedb.then((value) {
      if (value == null) {
        Future.delayed(Duration.zero, () {
          navigatorKey.currentState.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
        });
      } else {
        Provider.of<Store>(context, listen: false).cookie = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          showUnselectedLabels: true,
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [Find(), Video(), Mine(), CloudVilige(), Account()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          fixedColor: Colors.red,
          selectedFontSize: 12.0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '发现'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '视频'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '我的'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '云村'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '账号'),
          ],
          onTap: (int value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
      onGenerateRoute: (RouteSettings settings) => generateRoute(settings),
    );
  }
}
