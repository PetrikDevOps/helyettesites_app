import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:provider/provider.dart';

class SubPage extends StatefulWidget{
  const SubPage({super.key});

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage>{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color(0xFF41988A),
            Color(0xFF718935),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () async{
                await UserHelper.removeUserFromLs();
                context.read<UserProvider>().clearUser();
                context.go('/home');
              },
              child: const Text('Log Out'),
            ),
          ),
        ),
      ),
    );
  }
}
