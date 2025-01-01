import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:helyettesites/utils/models/drop_down_able.dart';
import 'package:helyettesites/utils/providers/p_classes.dart';
import 'package:helyettesites/utils/providers/p_teachers.dart';
import 'package:provider/provider.dart';

class HDropDown {
  static String url = "https://hely.petrik.lol/api";
  static String classesUrl = "/class";
  static String teachersUrl = "/teacher";
  static Dio dio = Dio(BaseOptions(baseUrl: url));

static Future<bool> getTeachers(BuildContext context) async {

    print("getTeachers");

    var res = await dio.get(teachersUrl);
    Map<String, dynamic> data = res.data;
    List<DropDownAble> teachers = (data["data"] as List).map((e) => DropDownAble.fromJson(e)).toList();

    try {
      if (context.mounted) {
      context.read<PTeachers>().setTeachers(
        await Future.delayed(Duration(seconds: 2), () => teachers)
      );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  
  static List<DropDownAble> sortStringsByNumberPart(List<DropDownAble> input) { 
    String extractRelevantPart(String s) {
      // Remove any prefix 
      if (s.contains('/')) {
        s = s.split('/').last;
      }
      // Getting the numeric part
      RegExp regex = RegExp(r'^\d+');
      Match? match = regex.firstMatch(s);
      return match?.group(0) ?? '0';
    }

    //numeric sort 
    input.sort((a, b) {
      int numA = int.parse(extractRelevantPart(a.name));
      int numB = int.parse(extractRelevantPart(b.name));

      // If the numbers are the same, sort by abc
      if (numA == numB) {
        return a.name.compareTo(b.name);
      }
      return numA.compareTo(numB);
    });

    return input;
  }


  static Future<bool> getClasses(BuildContext context) async {

    print("getClasses");

    var res = await dio.get(classesUrl);
    Map<String, dynamic> data = res.data;
    List<DropDownAble> classes = (data["data"] as List).map((e) => DropDownAble.fromJson(e)).toList();

    classes = sortStringsByNumberPart(classes);
  
    try {
      context.read<PClasses>().setClasses(
        await Future.delayed(Duration(seconds: 2), () => classes)
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

