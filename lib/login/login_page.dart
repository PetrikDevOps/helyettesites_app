
import 'package:flutter/material.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/utils/widgets/w_error.dart';
import 'package:helyettesites/utils/widgets/w_loading.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

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
          title: const Text('Login Page'),
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
                   
                  //return ScaleTransition(scale: animation, child: child);
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildContent(snapshot), // Helper method for readability
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return WLoading(
        key: ValueKey('loading'), // Unique key for AnimatedSwitcher
      );
    } else if (snapshot.hasError) {
      return WError(
        key: ValueKey('error'), // Unique key for AnimatedSwitcher
        error: snapshot.error.toString(),
      );
    } else {
      return const Center(
        key: ValueKey('success'), // Unique key for AnimatedSwitcher
        child: Text('Login successful'),
      );
    }
  }
}

