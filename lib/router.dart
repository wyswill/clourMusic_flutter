/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-09 14:12:55
 * @LastEditTime: 2020-11-09 15:49:58
 */

import 'package:flutter/material.dart';
import 'package:flutter_cloudMusic/pages/find.dart';
import 'package:flutter_cloudMusic/pages/login.dart';

Map routes = {
  "/login": (context, {arguments}) => Login(arguments: arguments),
  "/find": (context, {arguments}) => Find(arguments: arguments),
};

generateRoute(RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(
          context,
          arguments: settings.arguments,
        ),
      );
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
}
