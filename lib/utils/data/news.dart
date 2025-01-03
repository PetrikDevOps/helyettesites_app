import 'package:flutter/src/widgets/framework.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class News implements ITableAble {
  @override
  final DateTime date;
  final String news;

  const News({
    required this.date,
    required this.news,
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
