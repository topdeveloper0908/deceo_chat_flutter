import 'dart:async';
import 'dart:ui';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:doceo_new/amplifyconfiguration.dart';
import 'package:doceo_new/router/app_router.dart';
import 'package:doceo_new/services/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MyApp extends StatefulWidget {
  // final SharedPreferences sharedPreferences;
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  @override
  void dispose() {
    // _authProvider.dispose();
    super.dispose();
  }

  Future<void> configureAmplify() async {
    print('*******here**********');
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AppService>(create: (_) => appService),
        ChangeNotifierProvider(
          create: (_) => AuthenticateProviderPage(),
        ),
        // Provider<AppRouter>(create: (_) => AppRouter(appService)),
        // Provider<AuthService>(create: (_) => authService),
      ],
      child: Builder(
        builder: (context) {
          final _authProvider = AuthenticateProviderPage();
          final _router = routerGenerator(_authProvider);
          return MaterialApp.router(
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
            routerDelegate: _router.routerDelegate,
          );
        },
      ),
    );
  }
}
