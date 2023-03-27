import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPageA extends StatefulWidget {
  @override
  _SplashPageA createState() => new _SplashPageA();
}

class _SplashPageA extends State<SplashPageA> {
  String error = '';
  bool status = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          backgroundColor: Color(0xFFDCDADA),
          body: new SafeArea(
              child: new SingleChildScrollView(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new GestureDetector(
                      child: new Image.asset(
                        'assets/images/splash_1.png',
                        scale: 1,
                        fit: BoxFit.none,
                      ),
                      onTap: () {
                        context.go('/splash/b');
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
        onWillPop: () => Future.value(false));
  }
}
