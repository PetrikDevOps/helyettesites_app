import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helyettesites/login/login_page.dart';

class Routes {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/substitute',
        builder: (context, state) => Container(),
      ),
    ],
  );
}
