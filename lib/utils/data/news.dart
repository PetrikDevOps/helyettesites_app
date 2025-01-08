import 'package:flutter/widgets.dart';
import 'package:helyettesites/utils/data/t_table_able.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class News implements ITableAble {
  @override
  final DateTime date;
  @override
  final String id;
  @override
  final TTableAble type = TTableAble.news;
  final String news;

  const News({
    required this.date,
    required this.news,
    required this.id,
  });

  News.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        news = json["news"],
        id = json["id"];

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
