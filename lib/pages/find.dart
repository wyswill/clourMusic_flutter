/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-06 11:34:05
 * @LastEditTime: 2020-11-06 15:08:10
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
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
      body: Container(
        child: Text('find'),
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
}
