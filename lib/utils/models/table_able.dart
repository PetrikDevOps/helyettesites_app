class TableAble {
  final String id;
  final DateTime date;
  final bool consolidated;
  final String missingTeacerName;
  final String subingTeacherName;
  final String subjectName;
  final String roomName;
  final String className;
  final int lesson;


  const TableAble({
    required this.id,
    required this.date,
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

  factory TableAble.fromJson(Map<String, dynamic> json) {
    return TableAble(
      id: json['id'],
      date: DateTime.parse(json['date']),
      lesson: json['lesson'],
      consolidated: json['consolidated'],
      missingTeacerName: json['missingTeacher']['name'],
      subingTeacherName: json['teacher']['short'],
      subjectName: json['subject']['name'],
      roomName: json['room']['name'],
      className: json['class']['name'],
    );
  } 
}
