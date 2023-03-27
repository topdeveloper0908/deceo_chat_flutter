// ignore_for_file: avoid_print

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../../services/auth_provider.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPage createState() => new _VerificationPage();
}

class _VerificationPage extends State<VerificationPage> {
  TextEditingController verificationCode = new TextEditingController();
  int titleVal = 0;
  bool btnStatus = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      titleVal = AuthenticateProviderPage.of(context, listen: false).signVal;
    });
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
                      (titleVal == 0)
                          ? Column(
                              children: [
                                new Container(
                                  child: new Text(
                                    "確認コードを入力してください",
                                    style: new TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: new Text(
                                    AuthenticateProviderPage.of(context,
                                            listen: false)
                                        .verificationTitle,
                                    style: new TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                new Container(
                                  child: new Text(
                                    "認証番号を入力してください",
                                    style: new TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                new Container(
                                  child: new Text(
                                    AuthenticateProviderPage.of(context,
                                            listen: false)
                                        .verificationTitle,
                                    style: new TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEBECEE),
                            // suffixIcon: Icon(Icons.phone, color: Colors.grey),
                            focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            ),
                            enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: '',
                          ),
                          controller: verificationCode,
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
                            goSignIn();
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
                  )
                ],
              ),
            ),
          )),
        ),
        onWillPop: () => Future.value(false));
  }

  void goSignIn() async {
    setState(() {
      btnStatus = true;
    });
    String verificationTool =
        AuthenticateProviderPage.of(context, listen: false).verificationTool;
    if (verificationCode.text.length > 0) {
      try {
        final result = await Amplify.Auth.confirmSignUp(
            username: verificationTool,
            confirmationCode: verificationCode.text.toString());
        setState(() {
          btnStatus = false;
        });
        context.go('/signIn');
      } on AuthException catch (e) {
        safePrint(e.message);
        setState(() {
          btnStatus = false;
        });
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: 'エラー、認証コードが正しくありません!');
      }
    } else {
      setState(() {
        btnStatus = false;
      });
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToastDanger(message: 'エラーです。入力してください!');
    }
  }
}
