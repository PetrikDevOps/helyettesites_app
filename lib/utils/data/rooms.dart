import 'package:flutter/src/widgets/framework.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class Room implements ITableAble{
  @override
  final DateTime date;
  final String toRoomName;
  final String fromRoomName;
  final String className;

  const Room({
    required this.date,
    required this.toRoomName,
    required this.fromRoomName,
    required this.className,
  });

  Room.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        toRoomName = json["toRoom"]["short"],
        fromRoomName = json["fromRoom"]["short"],
        className = json["class"]["name"];

  @override
  String toString() {
    return 'Room{date: $date, toRoomName: $toRoomName, fromRoomName: $fromRoomName, className: $className}';
  } 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
