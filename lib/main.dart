import 'package:flutter/material.dart';
import 'package:helyettesites/routes/routes.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()), 
      ],
      child: const PetrikApp()
    )
  );
}

class PetrikApp extends StatelessWidget {
  const PetrikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( 
      title: 'Petrik',
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
