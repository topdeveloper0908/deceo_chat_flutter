import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';

class SplashPageB extends StatefulWidget {
  @override
  _SplashPageB createState() => new _SplashPageB();
}

class _SplashPageB extends State<SplashPageB> {
  String error = '';
  bool status = false;
  bool loading = true;
  bool vertorLoading = false;
  void initState() {
    super.initState();
    var now = new DateTime.now();
    var _hour = now.hour.toInt();
    var _min = now.minute.toInt();
    print(_hour);
    print(_min);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = !loading;
        vertorLoading = !vertorLoading;
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        loading = !loading;
        vertorLoading = !vertorLoading;
      });
      context.go('/splash/b/c');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          backgroundColor: Colors.white,
          body: new SafeArea(
            child: new Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                      opacity: loading ? 1.0 : 0.0,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 1000),
                      child: Image.asset('assets/images/letter.png')),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    opacity: vertorLoading ? 1.0 : 0.0,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Image.asset('assets/images/Vector.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () => Future.value(false));
  }
}
