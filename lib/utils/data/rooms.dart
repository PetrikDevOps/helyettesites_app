import 'package:helyettesites/utils/data/t_table_able.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class Room implements ITableAble {
  @override
  final DateTime date;
  @override
  final String id;
  @override
  final TTableAble type = TTableAble.room;
  final String toRoomName;

  @override
  final String name;
  final String className;

  const Room({
    required this.date,
    required this.id,
    required this.toRoomName,
    required this.name,
    required this.className,
  });

  Room.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        toRoomName = json["toRoom"]["short"],
        name = json["fromRoom"]["short"],
        className = json["class"]["name"],
        id = json["fromRoom"]["id"];

  @override
  String toString() {
    return 'Room{date: $date, toRoomName: $toRoomName, fromRoomName: $name, className: $className}';
  }
}
