import 'package:flutter/widgets.dart';
import 'user_type.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserHelper {
  static Future<bool> isUserInLs() async { 
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userType = prefs.getString('userType');
    print('checking user type');
    print('user type: $userType');
    return userType != null;
  } catch (e) {
    print('error in isUserInLs: $e');
    return false;
  }
  }

  static Future<bool> removeUserFromLs() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
    await prefs.remove('name');
    await prefs.remove('teacherId');
    await prefs.remove('classId');
    return true;
  } catch (e) {
    print('error in removeUserFromLs: $e');
    return false;
  }
  }


  static Future<bool> getUserFromLs(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userType = prefs.getString('userType');
  final String? name = prefs.getString('name');
  final String? teacherId = prefs.getString('teacherId');
  final String? classId = prefs.getString('classId');
  
  if (userType == null) return false;

  try {
    switch (userType) {
      case 'teacher':
        User user = User.teacher(name: name!, teacherId: teacherId!);
        context.read<UserProvider>().setUser(user);
        return true;
      case 'student':
        User user = User.student(name: name!, classId: classId!);
        context.read<UserProvider>().setUser(user);
        return true;
      default:
        return false;
    }
  } catch (e) {
    print('error in getUserFromLs: $e');
    return false;
  }
  }


  static Future<bool> saveToStorage(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool success = false;
  print('saving to storage');
  
  // Setting the user type 
  switch (user.userType) {
    case UserType.teacher:
      await prefs.setString('userType', 'teacher');
      await prefs.setString('teacherId', user.teacherId!);
      await prefs.setString('name', user.name);
      print('teacher data saved');
      success = true; 
      break;
    case UserType.student:
      await prefs.setString('userType', 'student');
      await prefs.setString('classId', user.classId!);
      await prefs.setString('name', user.name);
      print('student data saved');
      success = true;
      break;
    default:
      print('invalid user type');
      break;
  } 
  return success;
  }
}
