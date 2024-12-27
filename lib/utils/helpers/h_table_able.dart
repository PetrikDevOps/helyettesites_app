import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:helyettesites/utils/models/table_able.dart';
import 'package:helyettesites/utils/providers/p_sub.dart';
import 'package:provider/provider.dart';

class HTableAble {
  static String url = "https://hely-dev.petrik.lol/api";
  static String classesUrl = "/class";
  static String teachersUrl = "/teacher";
  static Dio dio = Dio(BaseOptions(baseUrl: url));

static Future<bool> getSub(BuildContext context) async {

    var res = await dio.get(teachersUrl);
    Map<String, dynamic> data = res.data;
    List<TableAble> tables = (data["data"] as List).map((e) => TableAble.fromJson(e)).toList();

    try {
      context.read()<PSub>().setSubs(
        await Future.delayed(Duration(seconds: 2), () => tables)
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static List<List<TableAble>> _groupAndOrder(List<TableAble> rows) {

    List<List<TableAble>> result = [];
    List<TableAble> temp = [];
    DateTime? lastDate;
    int? lastLesson; 
    rows.sort((a, b) => a.date.compareTo(b.date));
    rows.sort((a, b) => a.lesson.compareTo(b.lesson)); 
    rows.forEach((element) {
      if (lastDate == null || lastDate != element.date || lastLesson != element.lesson) {
        if (temp.isNotEmpty) {
          result.add(temp);
          temp = [];
        }
        lastDate = element.date;
        lastLesson = element.lesson;
      }
      temp.add(element);
    });
    if (temp.isNotEmpty) {
      result.add(temp);
    }
    return result;
  }

  static List<List<TableAble>> getGroupedAndOrderedSubs(BuildContext context) {
    return _groupAndOrder(context.watch<PSub>().subs);
  } 
}
