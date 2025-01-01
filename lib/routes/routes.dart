import 'package:go_router/go_router.dart';
import 'package:helyettesites/login/login_page.dart';
import 'package:helyettesites/substitutions/sub_page.dart';

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
        builder: (context, state) => SubPage(),
      ),
      GoRoute(
        path: '/loading', 
        builder: (context, state) => LoginPage()
      ),
    ],
  );
}
