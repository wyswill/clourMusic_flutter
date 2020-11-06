/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-06 11:34:05
 * @LastEditTime: 2020-11-06 16:22:28
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloudMusic/dto/banner.entity.dart';
import 'package:flutter_cloudMusic/utile.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Find extends StatefulWidget {
  Find({Key key}) : super(key: key);

  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> with TickerProviderStateMixin {
  bool isSearch = false;
  double opacityLevel = 1;
  FocusNode focusNode = FocusNode();
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _opacit;
  Request request;
  List<dynamic> banners = [];
  double size;
  List<Map<String, dynamic>> catgorys = [];
  @override
  void initState() {
    super.initState();
    request = Request();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = new Tween(begin: 55.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _opacit = new Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    size = 30;
    catgorys = [
      {"title": "每日推荐", "icon": Icon(Icons.five_mp, size: size)},
      {"title": "私人FM", "icon": Icon(Icons.calculate, size: size)},
      {"title": "歌单", "icon": Icon(Icons.calculate, size: size)},
      {"title": "排行榜", "icon": Icon(Icons.calculate, size: size)},
      {"title": "直播", "icon": Icon(Icons.calculate, size: size)},
      {"title": "电台", "icon": Icon(Icons.calculate, size: size)},
      {"title": "数字专辑", "icon": Icon(Icons.calculate, size: size)},
      {"title": "唱聊", "icon": Icon(Icons.calculate, size: size)},
    ];
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    try {
      Response<Map<String, dynamic>> bannerlist =
          await request.dio.get('/banner?type=2');
      banners = bannerlist.data["banners"];
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Opacity(
            opacity: _opacit.value,
            child: IconButton(icon: Icon(Icons.search), onPressed: () {})),
        leadingWidth: _animation.value,
        title: search(),
        centerTitle: true,
        actions: [
          AnimatedCrossFade(
            duration: const Duration(seconds: 1),
            sizeCurve: Curves.easeInOut,
            secondChild: IconButton(
              icon: Icon(Icons.circle),
              onPressed: () {},
            ),
            firstChild: TextButton(
                onPressed: () {
                  setState(() {
                    isSearch = false;
                    _controller.reverse();
                    focusNode.unfocus();
                  });
                },
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.white),
                )),
            crossFadeState:
                isSearch ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bannerSet(),
            cats(),
          ],
        ),
      ),
    );
  }

  Widget search() {
    TextEditingController controller = TextEditingController();
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white),
        ),
        onTap: () {
          setState(() {
            isSearch = true;
            _controller.forward();
          });
        },
        onSubmitted: (serchStr) {
          print(serchStr);
          setState(() {
            isSearch = false;
            _controller.reverse();
            focusNode.unfocus();
          });
        },
      ),
    );
  }

  Widget bannerSet() => Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Swiper(
          autoplay: true,
          viewportFraction: 0.8,
          scale: 0.9,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(banners[index]['pic'], fit: BoxFit.fill);
          },
          itemCount: banners.length,
        ),
      );
  Widget cats() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            catgorys.length,
            (index) => Container(
              width: 90,
              height: 90,
              child: Column(
                children: [
                  IconButton(
                    color: Colors.green,
                    icon: catgorys[index]['icon'],
                    onPressed: () {},
                  ),
                  Text(catgorys[index]['title'],
                      style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
          ),
        ),
      );
}
