import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/pages/landing/landing_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        path: '/another',
        builder: (context, state) => AnotherPage(),
      ),
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

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('Welcome to Another Page!'),
      ),
    );
  }
}
