import 'package:helyettesites/utils/data/t_table_able.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';

class Subs implements ITableAble {
  @override
  final DateTime date;

  @override
  final String id;
  @override
  final TTableAble type = TTableAble.sub;
  final bool consolidated;

  @override
  final String name;
  final String subingTeacherName;
  final String subjectName;
  final String roomName;
  final String className;
  final int lesson;

  const Subs(
      {required this.date,
      required this.id,
      required this.consolidated,
      required this.name,
      required this.subingTeacherName,
      required this.subjectName,
      required this.roomName,
      required this.className,
      required this.lesson});

  @override
  String toString() {
    return 'Sub{date: $date, missingTeacerName: $name, subingTeacherName: $subingTeacherName, className: $className, lesson: $lesson}';
  }

  factory Subs.fromJson(Map<String, dynamic> json) {
    return Subs(
      id: json['id'],
      date: DateTime.parse(json['date']),
      lesson: json['lesson'],
      consolidated: json['consolidated'],
      name: json['missingTeacher']['name'],
      subingTeacherName: json['teacher']['name'],
      subjectName: json['subject']['name'],
      roomName: json['room']['short'],
      className: json['class']['name'],
    );
  }
}
