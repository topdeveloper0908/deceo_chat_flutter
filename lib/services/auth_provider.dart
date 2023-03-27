import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:doceo_new/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class AuthenticateProviderPage extends ChangeNotifier {
  static AuthenticateProviderPage of(BuildContext context,
          {bool listen = false}) =>
      Provider.of<AuthenticateProviderPage>(context, listen: listen);

  int _signVal = 0;
  bool _isAuthenticated = false;
  String _verificationTitle = "";
  String _verificationTool = "";
  String _birthday = "";
  String _password = "";
  String _userName = "";

  get password => _password;
  get userName => _userName;
  get isAuthenticated => _isAuthenticated;
  get signVal => _signVal;
  get verificationTitle => _verificationTitle;
  get verificationTool => _verificationTool;
  get birthday => _birthday;

  set password(val) {
    _password = val;
    notifyListeners();
  }

  set userName(val) {
    _userName = val;
    notifyListeners();
  }

  set isAuthenticated(val) {
    _isAuthenticated = val;
    setLoginStatus(val);
    notifyListeners();
  }

  set birthday(val) {
    _birthday = val;
    notifyListeners();
  }

  set verificationTitle(val) {
    _verificationTitle = val;
    notifyListeners();
  }

  set signVal(val) {
    _signVal = val;
    notifyListeners();
  }

  set verificationTool(val) {
    _verificationTool = val;
    notifyListeners();
  }

  // Future<void> setUserModel(UserModel userModel,
  //     {bool isNotifiable = true}) async {
  //   _userModel = userModel;
  //   if (isNotifiable) notifyListeners();
  // }
  void notifyToast({message}) {
    Toast.show(message, duration: Toast.center, gravity: Toast.bottom);
  }

  void notifyToastDanger({message}) {
    Toast.show(message,
        duration: Toast.center,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
        webTexColor: Colors.white);
  }

  void notifyToastSuccess(message) {
    Toast.show(message,
        duration: Toast.center,
        gravity: Toast.bottom,
        backgroundColor: Colors.green,
        webTexColor: Colors.white);
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  Future<void> setLoginStatus(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool("loginStatus", val);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var value = sharedPreference.getBool("loginStatus") ?? false;
    return Future<bool>.value(value);
  }
}
