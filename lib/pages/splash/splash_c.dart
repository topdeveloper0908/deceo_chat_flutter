import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';

class SplashPageC extends StatefulWidget {
  @override
  _SplashPageC createState() => new _SplashPageC();
}

class _SplashPageC extends State<SplashPageC>
    with SingleTickerProviderStateMixin {
  String error = '';
  bool imageStatus = true;
  double scale = 1.1;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        imageStatus = !imageStatus;
      });
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ),
      );

      _controller.addListener(() {
        setState(() {});
        if (_controller.value == 1.0) {
          context.go('/sel');
        } else {}
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: imageStatus
                  ? Container(
                      child: Image.asset(
                        'assets/images/finish-render.png',
                        scale: 1,
                      ),
                    )
                  : Opacity(
                      opacity: 1 - _controller.value,
                      child: Center(
                          child: AnimatedScale(
                        scale: scale * (1 + _controller.value),
                        duration: const Duration(seconds: 3),
                        child: Image.asset('assets/images/finish-render_2.png'),
                      )),
                      // child: Image.asset(
                      //   'assets/images/finish-render_2.png',
                      //   width: MediaQuery.of(context).size.width *
                      //       (1 + _controller.value),
                      //   height: MediaQuery.of(context).size.height *
                      //       (1 + _controller.value),
                      // ),
                    )),
        ),
        onWillPop: () => Future.value(false));
  }
}
