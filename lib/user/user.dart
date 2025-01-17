import 'package:helyettesites/user/user_type.dart';

class User {
  UserType userType;
  String name;
  String? teacherId;
  String? classId;

  User.none()
      : userType = UserType.none,
        name = '';
  User.guest()
      : userType = UserType.guest,
        name = '';
  User.teacher({required this.name, required this.teacherId})
      : userType = UserType.teacher;
  User.student({required this.name, required this.classId})
      : userType = UserType.student;

  @override
  toString() {
    return 'User: {name: $name, userType: $userType, teacherId: $teacherId, classId: $classId}';
  }

  List<String> get url {
    switch (userType) {
      case UserType.student:
        return ['?classId=$classId'];
      case UserType.teacher:
        return ['?teacherId=$teacherId', '?missingTeacherId=$teacherId'];
      case UserType.guest:
        return [''];
      default:
        return [];
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['teacherId'] != null) {
      return User.teacher(name: json['name'], teacherId: json['teacherId']);
    } else {
      return User.student(name: json['name'], classId: json['classId']);
    }
  }
}
