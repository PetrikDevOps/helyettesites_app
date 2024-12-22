
import 'package:flutter/material.dart';
import 'package:helyettesites/login/login_form.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/utils/widgets/w_error.dart';
import 'package:helyettesites/utils/widgets/w_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); 

  @override
  State<LoginPage> createState() => _LoginPageState();
}


//Bulind the base of the login page 
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: const Text("Bejelentkezés"),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: UserHelper.isUserInLs(),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (Widget child, Animation<double> animation) {                   
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildContent(snapshot),
              );
            },
          ),
        ),
      ),
    );
  }


  // Build content based on the state of the future snapshot
  Widget _buildContent(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return WLoading(
        key: ValueKey('loading'),
      );
    } else if (snapshot.hasError) {
      return WError(
        key: ValueKey('error'),
        error: snapshot.error.toString(),
      );
    } else {
      if (snapshot.data == false) {
        return  Center(
          key: ValueKey('login'),
          child: LoginForm(),
        );
      }
      return const Center(
        key: ValueKey('logout'),
        child: Text('Logout form'),
      );
    }
  }
}

