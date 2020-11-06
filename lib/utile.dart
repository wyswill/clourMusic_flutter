/*
 * @LastEditors: wyswill
 * @Description: 工具类
 * @Date: 2020-11-06 15:14:50
 * @LastEditTime: 2020-11-06 15:24:41
 */

import 'package:dio/dio.dart';

class Request {
  Dio dio;
  Request() {
    dio = Dio();
    dio.options.baseUrl = 'http://192.168.2.152:3200';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
  }
}
