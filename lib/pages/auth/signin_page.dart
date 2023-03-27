// ignore_for_file: avoid_print

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:doceo_new/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() => new _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  bool _passwordVisible = true;
  bool btnStatus = false;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                context.go('/sel');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const Text(
              "戻る",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
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
                        child: Text(
                          'おかえりなさい！',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'アカウント情報',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: new TextFormField(
                              // obscureText: _passwordVisible,

                              decoration: new InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffEBECEE),
                                  suffixIcon:
                                      Icon(Icons.email, color: Colors.grey),
                                  focusedBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: '電話番号またはメールアドレス',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                              controller: email,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: new TextFormField(
                              obscureText: _passwordVisible,
                              decoration: new InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffEBECEE),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'パスワード',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              controller: password,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              'パスワードをお忘れですか？',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xff1997F6)),
                            ),
                          ),
                        ],
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
                            goHome();
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
                              child: btnStatus
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      strokeWidth: 1)
                                  : const Text(
                                      '次へ',
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

  void goHome() async {
    setState(() {
      btnStatus = true;
    });
    if (email.text.length > 0 && password.text.length > 0) {
      try {
        final result = await Amplify.Auth.signIn(
          username: email.text.toString(),
          password: password.text.toString(),
        );
        setState(() {
          btnStatus = false;
        });
        AuthenticateProviderPage.of(context, listen: false).isAuthenticated =
            true;
        context.go('/home');
      } on AuthException catch (e) {
        safePrint(e.message);
        setState(() {
          btnStatus = false;
        });
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: "サインイン エラーです。もう一度お試しください。");
      }
    } else {
      setState(() {
        btnStatus = false;
      });
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToastDanger(message: "エラー、すべての入力を埋めてください!");
    }
  }
}
