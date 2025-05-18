import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/pages/landing/landing_page.dart';
import 'package:flutter_app/pages/account/signin_page.dart';
import 'package:flutter_app/pages/account/signup_page.dart';
import 'package:flutter_app/pages/dashboard/dashboard.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        path: '/account/signin',
        builder: (context, state) => SigninPage(),
      ),
      GoRoute(
          path: '/account/signup', builder: (context, state) => SignupPage()),
      GoRoute(path: '/dashboard', builder: (context, state) => DashboardPage()),
    ],
    errorBuilder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go('/');
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
