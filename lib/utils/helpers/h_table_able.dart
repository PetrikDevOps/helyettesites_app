import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/user/user_type.dart';
import 'package:helyettesites/utils/models/table_able.dart';
import 'package:helyettesites/utils/providers/p_sub.dart';
import 'package:provider/provider.dart';

class HTableAble {
  static String url = "https://hely.petrik.lol/api/substitution";
  static Dio dio = Dio(BaseOptions(baseUrl: url));

static Future<bool> getSub(BuildContext context) async {

    User user = context.read<UserProvider>().user;
    List<String> sub_url = [];
    switch (user.userType) {
      case UserType.student:
        sub_url = ['?classId=${user.classId}']; 
        break;
      case UserType.teacher:
        sub_url = ['?teacherId=${user.teacherId}', '?missingTeacherId=${user.teacherId}']; 
        break;
      case UserType.guest:
        sub_url = [''];
        break; 
      default:
        return false;
    }

    var res = await Future.wait(sub_url.map((e) => dio.get(url + e)));

    if (res.any((element) => element.statusCode != 200)) {
      return false;
    }

    if ( res.any((element) => element.data["status"] != "success")) {
      return false;
    }

    List<TableAble> temp = [];

    res.forEach((element) {
      List<TableAble> tables = (element.data["data"] as List).map((e) => TableAble.fromJson(e)).toList();
      temp.addAll(tables);
    });

    List<DateTime> dates = temp.map((e) => e.date).toSet().toList();

    List<List<List<TableAble>>> grouped = [];

    dates.forEach((date) {
      List<TableAble> temp2 = temp.where((element) => element.date == date).toList();
      List<String> missingTeacherNames = temp2.map((e) => e.missingTeacerName).toSet().toList();

      List<List<TableAble>> missingTeachersGroups = [];
      missingTeacherNames.forEach((missingTeacher) {
        List<TableAble> temp3 = temp2.where((element) => element.missingTeacerName == missingTeacher).toList();
        temp3.sort((a, b) => a.lesson.compareTo(b.lesson));
        missingTeachersGroups.add(temp3); 
      });

      grouped.add(missingTeachersGroups);
    });

    grouped.forEach((e) {
      e.forEach((element) {
        print(element);
      });
    });

    if (context.mounted) {
      context.read<PSub>().setSubs(grouped);
      return true;
    }
    return false;
  }

  static Widget _buildTable(BuildContext context, List<TableAble> tb) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
  
    return SizedBox(
          width: width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(tb[0].missingTeacerName),  
                  ],
                ),
                ...tb.map((e) => Row(
                  children: [
                    Text(e.lesson.toString()),
                    Text(e.className), 
                    Text(e.subingTeacherName),
                  ],
                )).toList(),
              ]
            ),
          ),
        );
  }

  static String _convertDate(DateTime date) {
    return "${date.year} ${date.month} ${date.day}";
  }

  static Widget buildList(BuildContext context) {
    List<List<List<TableAble>>> subs = context.watch<PSub>().subs;
  
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.95,
      height: height * 0.8,
      child: ListView.builder(
        itemCount: subs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(width * 0.01),
            decoration: BoxDecoration(
              color: Color(0x4FE0E0E0),
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(_convertDate(subs[index][0][0].date)),
                  ...subs[index].map((e) => _buildTable(context, e)).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
