import 'package:flutter/widgets.dart';
import 'user_type.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserHelper {
  // testing if user is in local storage
  static Future<bool> isUserInLs() async {
    await Future.delayed(Duration(seconds: 2)); 
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userType = prefs.getString('userType');
      return userType != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> getUserFromLs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userType = prefs.getString('userType');
    final String? name = prefs.getString('name');
    final int? teacherId = prefs.getInt('teacherId');
    final int? classId = prefs.getInt('classId');
    bool success = false;
    if (userType == null) {
      return success;
    }


    switch (userType) {
      case 'teacher':
        User user = User.teacher(name: name!, teacherId: teacherId!);
        context.read<UserProvider>().setUser(user);
        success = true;
        break;
      case 'student':
        User user = User.student(name: name!, classId: classId!);
        context.read<UserProvider>().setUser(user);
        success = true;
        break;
      default:
        success = false;
        break;
    }
    return success;
  }

  static Future<bool> saveToStorage(User user) async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync(); 
    bool success = false;

    //setting the user type 
    switch (user.userType) {
      case UserType.teacher:
        await asyncPrefs.setString('userType', 'teacher');
        await asyncPrefs.setInt('teacherId', user.teacherId!);
        await asyncPrefs.setString('name', user.name);
        success = true; 
        break;
      case UserType.student:
        await asyncPrefs.setString('userType', 'student');
        await asyncPrefs.setInt('classId', user.classId!);
        await asyncPrefs.setString('name', user.name);
        success = true;
        break;
      default:
        break;
    } 
    return success;
  } 
}
