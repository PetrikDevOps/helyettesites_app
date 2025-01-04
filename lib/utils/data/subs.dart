import 'package:flutter/cupertino.dart';
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
  final String missingTeacerName;
  final String subingTeacherName;
  final String subjectName;
  final String roomName;
  final String className;
  final int lesson;


  const Subs({
    required this.date,
    required this.id,
    required this.consolidated,
    required  this.missingTeacerName,
    required  this.subingTeacherName,
    required  this.subjectName,
    required  this.roomName,
    required  this.className,
    required this.lesson
  });

  @override
  String toString() {
    return 'date: $date, missingTeacerName: $missingTeacerName, subingTeacherName: $subingTeacherName, className: $className, lesson: $lesson';
  }

  factory Subs.fromJson(Map<String, dynamic> json) {
    return Subs(
      id: json['id'],
      date: DateTime.parse(json['date']),
      lesson: json['lesson'],
      consolidated: json['consolidated'],
      missingTeacerName: json['missingTeacher']['name'],
      subingTeacherName: json['teacher']['name'],
      subjectName: json['subject']['name'],
      roomName: json['room']['short'],
      className: json['class']['name'],
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
