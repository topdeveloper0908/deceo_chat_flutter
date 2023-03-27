import 'dart:isolate';

import 'package:doceo_new/pages/home/home_page.dart';
import 'package:doceo_new/router/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../pages/auth/signin_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/auth/verification_page.dart';
import '../pages/auth/birthday_page.dart';
import '../pages/auth/newpassword_page.dart';
import '../pages/splash/sel_page.dart';
import '../pages/splash/splash_a.dart';
import '../pages/splash/splash_b.dart';
import '../pages/splash/splash_c.dart';
import '../services/auth_provider.dart';

GoRouter routerGenerator(AuthenticateProviderPage _authProvider) {
  // final isAuthenticated = AuthProvider.of(context, listen: false).birthday;
  // late final AppService appService;
  // AppRouter(this.appService);
  // GoRouter get router => _goRouter;

  return GoRouter(
      // refreshListenable: appService,
      initialLocation: '/splash',
      routes: [
        GoRoute(
            //newPassword
            path: '/splash',
            name: AppRoute.splash.name,
            builder: (context, state) => SplashPageA(),
            routes: [
              GoRoute(
                  path: "b",
                  builder: (context, state) => SplashPageB(),
                  routes: [
                    GoRoute(
                        path: "c", builder: (context, state) => SplashPageC())
                  ])
            ]),
        GoRoute(
            path: '/sel',
            name: AppRoute.sel.name,
            builder: (context, state) => SelPage()),
        // signIn
        GoRoute(
            path: '/signIn',
            name: AppRoute.signIn.name,
            builder: (context, state) => SignInPage()),
        GoRoute(
            // signUp
            path: '/signUp',
            name: AppRoute.signUp.name,
            builder: (context, state) => SignUpPage()),
        GoRoute(
            // verification
            path: '/verification',
            name: AppRoute.verification.name,
            builder: (context, state) => VerificationPage()),
        GoRoute(
            // birthday
            path: '/birthday',
            name: AppRoute.birthday.name,
            builder: (context, state) => BirthdayPage()),
        GoRoute(
            // newPassword
            path: '/newPassword',
            name: AppRoute.newPassword.name,
            builder: (context, state) => NewPasswordPage()),
        GoRoute(
            path: '/home',
            name: AppRoute.home.name,
            builder: (context, state) => HomePage(),
            redirect: (state) {}),
      ],
      errorBuilder: (context, state) => Scaffold(
            body: Center(
              child: Text(state.error.toString()),
            ),
          ),
      redirect: (state) {
        // print('jgj');
        // print(_authProvider.isAuthenticated);
        // if (_authProvider.isAuthenticated == false) {
        //   return '/newPassword';
        // } else {
        //   return '/sel';
        // }
        return null;
      });
}
