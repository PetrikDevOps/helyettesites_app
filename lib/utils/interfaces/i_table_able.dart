import 'package:helyettesites/utils/data/t_table_able.dart';

abstract interface class ITableAble {
  final DateTime date;
  final String id;
  final TTableAble type;
  final String name;

  //const
  ITableAble({
    required this.date,
    required this.id,
    required this.type,
    required this.name,
  });
}
