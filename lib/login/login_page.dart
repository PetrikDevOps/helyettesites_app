import 'package:flutter/material.dart';
import 'package:helyettesites/login/login_form.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/utils/helpers/h_drop_down.dart';
import 'package:helyettesites/utils/providers/p_tables.dart';
import 'package:helyettesites/utils/widgets/w_error.dart';
import 'package:helyettesites/utils/widgets/w_loading.dart';
import 'package:provider/provider.dart';

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
        body: SafeArea(
          child: FutureBuilder<List<dynamic>>(
            future: Future.wait([
              UserHelper.isUserInLs(),
              UserHelper.getUserFromLs(context), 
              HDropDown.getTeachers(context),
              HDropDown.getClasses(context),
              context.read<PTables>().init(context),
            ]),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (Widget child, Animation<double> animation) {                   
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildContent(snapshot, context),
              );
            },
          ),
        ),
      ),
    );
  }


  // Build content based on the state of the future snapshot
  Widget? _buildContent(AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return WLoading(
        key: ValueKey('loading'),
      );
    } else if (snapshot.hasError || snapshot.data[2] == false || snapshot.data[3] == false) {
      return WError(
        key: ValueKey('error'),
        error: snapshot.error.toString(),
      );
    } else {
        return  Center(
          key: ValueKey('login'),
          child: LoginForm(),
        );
      }
  }
}

