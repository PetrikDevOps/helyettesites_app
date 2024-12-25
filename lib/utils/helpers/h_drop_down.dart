import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:helyettesites/utils/models/drop_down_able.dart';
import 'package:helyettesites/utils/providers/p_classes.dart';
import 'package:helyettesites/utils/providers/p_teachers.dart';
import 'package:provider/provider.dart';

class HDropDown {
  static String url = "https://hely-dev.petrik.lol/api";
  static String classesUrl = "/class";
  static String teachersUrl = "/teacher";
  static Dio dio = Dio(BaseOptions(baseUrl: url));

static Future<bool> getTeachers(BuildContext context) async {

    var res = await dio.get(teachersUrl);
    Map<String, dynamic> data = res.data;
    List<DropDownAble> teachers = (data["data"] as List).map((e) => DropDownAble.fromJson(e)).toList();

    try {
      context.read<PTeachers>().setTeachers(
        await Future.delayed(Duration(seconds: 2), () => teachers)
      );
      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> getClasses(BuildContext context) async {
    var res = await dio.get(classesUrl);
    Map<String, dynamic> data = res.data;
    List<DropDownAble> classes = (data["data"] as List).map((e) => DropDownAble.fromJson(e)).toList();

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

