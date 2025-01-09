import 'package:flutter/material.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class WTable extends StatelessWidget {
  final List<ITableAble> tables;
  const WTable({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.9,
      child: Column(children: [
        //header

        //body
      ]),
    );
  }
}
