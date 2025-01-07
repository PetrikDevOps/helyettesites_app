import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/utils/helpers/h_table_able.dart';
import 'package:helyettesites/utils/providers/p_tables.dart';
import 'package:helyettesites/utils/widgets/w_error.dart';
import 'package:helyettesites/utils/widgets/w_loading.dart';
import 'package:provider/provider.dart';

class SubPage extends StatefulWidget {
  const SubPage({super.key});

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  Widget _buildContent(AsyncSnapshot snapshot, BuildContext context) {
    final User u = context.watch<UserProvider>().user;

    if (snapshot.connectionState == ConnectionState.waiting) {
      return WLoading(key: ValueKey('loadingSub'));
    }
    if (snapshot.hasError) {
      return WError(
          error: snapshot.error.toString(), key: ValueKey('errorSub'));
    }
    if (snapshot.data == false) {
      return Center(
        key: ValueKey('notLoggedIn'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nem sikerült bejelentkezni!'),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: Text('Bejelentkezés'),
            ),
          ],
        ),
      );
    }
    return Center(
      key: ValueKey('loggedIn'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Üdvözöllek ${u.name}!'),
          ElevatedButton(
            onPressed: () async {
              await UserHelper.removeUserFromLs();
              context.read<UserProvider>().setUser(User.none());
              context.go('/home');
            },
            child: Text('Kijelentkezés'),
          ),
          HTableAble.buildList(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User u = context.watch<UserProvider>().user;
    context.read<PTables>().init(context);

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
              UserHelper.saveToStorage(u),
              HTableAble.getSub(context),
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
}
