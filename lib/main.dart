import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helyettesites/routes/routes.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/utils/providers/p_classes.dart';
import 'package:helyettesites/utils/providers/p_sub.dart';
import 'package:helyettesites/utils/providers/p_teachers.dart';
import 'package:helyettesites/view_models/p_tables.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => PTeachers()),
    ChangeNotifierProvider(create: (context) => PClasses()),
    ChangeNotifierProvider(create: (context) => PSub()),
    ChangeNotifierProvider(create: (context) => TablesViewModel(context)),
  ], child: const PetrikApp()));
}

class PetrikApp extends StatelessWidget {
  const PetrikApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp.router(
      title: 'Petrik',
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
