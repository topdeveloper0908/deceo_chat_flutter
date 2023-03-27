// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../services/auth_provider.dart';

class BirthdayPage extends StatefulWidget {
  @override
  _BirthdayPage createState() => new _BirthdayPage();
}

class _BirthdayPage extends State<BirthdayPage> {
  TextEditingController birthday = new TextEditingController();
  int titleVal = 0;
  DateTime selectedDate = DateTime.now();
  String _dobValue = '';
  @override
  void initState() {
    super.initState();
    birthday.text =
        AuthenticateProviderPage.of(context, listen: false).birthday;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1930),
      lastDate: DateTime(2900),
    );
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      _dobValue = DateFormat('yyyy-MM-dd').format(picked);
      if (mounted)
        setState(() {
          selectedDate = picked;
          birthday.text = formattedDate;
        });
    }
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
                context.go('/signUp');
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
                        // padding: EdgeInsets.only(top: ),
                        child: Text(
                          '誕生日を入力してください',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      )
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
                            suffixIcon: InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Icon(Icons.calendar_month,
                                  color: Colors.grey),
                            ),
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
                          controller: birthday,
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
                            goNewPassword();
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

  void goNewPassword() {
    if (birthday.text.length > 0) {
      AuthenticateProviderPage.of(context, listen: false).birthday =
          birthday.text;
      context.go('/newPassword');
    } else {
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToast(message: "あなたの誕生日を入力してください。");
    }
  }
}
