import 'package:flutter/material.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/view_models/p_tables.dart';
import 'package:provider/provider.dart';

class SubDisplayPage extends StatelessWidget {
  const SubDisplayPage({super.key});

  Widget _build(TablesViewModel tables) {
    if (tables.isLoading) {
      return Center(
        key: ValueKey('loadingSub'),
        child: CircularProgressIndicator(),
      );
    }
    if (tables.error != null) {
      return Center(
        key: ValueKey('errorSub'),
        child: Text(tables.error.toString()),
      );
    }
    if (tables.tables.isEmpty) {
      return Center(
        key: ValueKey('noTables'),
        child: Text('Nincsenek asztalok'),
      );
    }

    return ListView.builder(
      key: ValueKey('tables'),
      itemCount: tables.tables.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text('Dátum: ${tables.tables[index][0][0].date}'),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User u = context.watch<UserProvider>().user;
    TablesViewModel tables = context.watch<TablesViewModel>();
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
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _build(tables),
          ),
        ),
      ),
    );
  }
}
