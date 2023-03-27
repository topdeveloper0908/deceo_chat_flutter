// ignore_for_file: avoid_print

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:doceo_new/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPage createState() => new _NewPasswordPage();
}

class _NewPasswordPage extends State<NewPasswordPage> {
  bool _passwordVisible = true;
  bool btnStatus = false;
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
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
                context.go('/birthday');
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
                          '登録',
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
                              'ユーザー名を入力',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Color(0xffEBECEE),
                                // suffixIcon: Icon(Icons.phone, color: Colors.grey),
                                focusedBorder: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black),
                                ),
                                enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: '',
                              ),
                              controller: username,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '後からいつでも変更できます！',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
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
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'パスワードを入力',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
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
                                hintText: '',
                              ),
                              controller: password,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              'パスワードは、英数字小文字大文字含む8文字以上で！',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
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
                            // context.go('/');
                            // getVeificationCode();
                            getVerification();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '登録を行うことで、DOCEOの サービス利用規約 及び プライ\nバシーポリシー に同意したものとみなされます。',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
        ),
        onWillPop: () => Future.value(false));
  }

  void getVerification() async {
    setState(() {
      btnStatus = true;
    });
    AuthenticateProviderPage.of(context, listen: false).userName =
        username.text.toString();
    AuthenticateProviderPage.of(context, listen: false).password =
        password.text.toString();
    int selVal = AuthenticateProviderPage.of(context, listen: false).signVal;
    String verificationTool =
        AuthenticateProviderPage.of(context, listen: false).verificationTool;
    String birthday =
        AuthenticateProviderPage.of(context, listen: false).birthday;
    String userName = username.text;
    if (username.text.length > 0 && password.text.length > 0) {
      if (password.text.length >= 8) {
        if (selVal == 0) {
          try {
            final userAttributes = <CognitoUserAttributeKey, String>{
              CognitoUserAttributeKey.phoneNumber: verificationTool,
              // additional attributes as needed
            };
            final result = await Amplify.Auth.signUp(
              username: verificationTool,
              password: password.text.toString(),
              options: CognitoSignUpOptions(userAttributes: userAttributes),
            );
            setState(() {
              btnStatus = false;
            });
            context.go('/verification');
          } on AuthException catch (e) {
            safePrint(e.message);
            setState(() {
              btnStatus = false;
            });
            AuthenticateProviderPage.of(context, listen: false)
                .notifyToastDanger(message: "エラー サインアップ!, もう一度お試しください!");
          }
        } else {
          try {
            final userAttributes = <CognitoUserAttributeKey, String>{
              CognitoUserAttributeKey.email: verificationTool,
              // additional attributes as needed
            };
            final result = await Amplify.Auth.signUp(
              username: verificationTool,
              password: password.text.toString(),
              options: CognitoSignUpOptions(userAttributes: userAttributes),
            );
            context.go('/verification');
            setState(() {
              btnStatus = false;
            });
          } on AuthException catch (e) {
            safePrint(e.message);
            setState(() {
              btnStatus = false;
            });
            AuthenticateProviderPage.of(context, listen: false)
                .notifyToastDanger(message: "エラー サインアップ!, もう一度お試しください!");
          }
        }
      } else {
        setState(() {
          btnStatus = false;
        });
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: "エラーです。パスワードは 8 文字以上にする必要があります。");
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
