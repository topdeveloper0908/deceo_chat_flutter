// ignore_for_file: avoid_print

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:doceo_new/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  int titleVal = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return new WillPopScope(
        child: new Scaffold(
          backgroundColor: Colors.white,
          body: new SafeArea(
              child: new SingleChildScrollView(
            // ignore: unnecessary_new
            child: new SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          'Success Logined',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            // context.go('/');
                            // getVeificationCode();
                            goLogOut();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xffB44DD9),
                                  Color(0xff70A4F2)
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text(
                                'Log Out',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ),
        onWillPop: () => Future.value(false));
  }

  Future<void> goLogOut() async {
    try {
      await Amplify.Auth.signOut();
      AuthenticateProviderPage.of(context, listen: false).isAuthenticated =
          false;
      context.go('/sel');
    } on AuthException catch (e) {
      print(e.message);
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToastDanger(message: "サインアウト エラーです。もう一度お試しください。");
    }
  }
}
