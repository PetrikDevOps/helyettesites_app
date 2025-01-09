import 'package:flutter/material.dart';
import 'package:helyettesites/view_models/p_tables.dart';
import 'package:helyettesites/views/w_table.dart';
import 'package:provider/provider.dart';

class SubDisplayPage extends StatelessWidget {
  const SubDisplayPage({super.key});

  Widget _build(TablesViewModel tables, BuildContext context) {
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
        child: Text('Nincsenek változások.'),
      );
    }

    return ListView.builder(
      key: ValueKey('tables'),
      itemCount: tables.tables.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text('Dátum: ${tables.tables[index][0][0].date}'),
            WTable(tables: tables.tables[index][0]),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: _build(tables, context),
          ),
        ),
      ),
    );
  }
}
