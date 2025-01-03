import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/user/user_type.dart';
import 'package:helyettesites/utils/data/table_able.dart';
import 'package:helyettesites/utils/providers/p_sub.dart';
import 'package:helyettesites/utils/widgets/w_scrollable_autoscrolling_text.dart';
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

    print("sub_url: $sub_url");

    var res = await Future.wait(sub_url.map((e) => dio.get(url + e)));

    print(res);

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

  static Widget _buildScrollAbleText(BuildContext context, String text, Border border) {
    return WScrollableAutoscrollingText(text: text, border: border);  
  }

  static Widget _buildTable(BuildContext context, List<TableAble> tb) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
  
    return SizedBox(
          width: width * 1,
          child: Container(
            margin: EdgeInsets.only(top: height * 0.01),
            decoration: BoxDecoration(
              color: Color(0x3F000000),
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(tb[0].missingTeacerName, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xDFFFFFFF), fontSize: width * 0.06)),  
                    ],
                  ),
                  SizedBox(height: height * 0.002),
                  SizedBox(height: height * 0.002,
                    child: Container(
                      decoration: BoxDecoration( 
                        color: Color(0xA0F0F0F0),
                      ),
                    ),
                  ),
                  
                  ...tb.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;
                    BorderRadius borderRadius = index == tb.length - 1 ? BorderRadius.only(bottomLeft: Radius.circular(width * 0.03), bottomRight: Radius.circular(width * 0.03)) : BorderRadius.circular(0);
                    // Decide the background color based on whether the index is even or odd
                    Color backgroundColor = index % 2 == 0 ? Color(0x20FFFFFF) : Color(0x00000000);
            
                    return Container(
                      decoration: BoxDecoration( 
                        color: backgroundColor,
                        borderRadius: borderRadius,
                        border: Border(
                          top: BorderSide(color: Color(0xFFF0F0F0)),
                        )
                      ),
                      width: width * 0.95,
                      height: height * 0.11,
                      margin: EdgeInsets.all(width * 0), 
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                            child: Row(
                            
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(width: width * 0.12, child: _buildScrollAbleText(context, e.lesson.toString(), Border(
                                right: BorderSide(color: Color(0x4FF0F0F0)),
                              ))),  
                              SizedBox(width: width * 0.18, child: _buildScrollAbleText(context, e.className, Border(
                                right: BorderSide(color: Color(0x4FF0F0F0)),
                              ))),
                              SizedBox(width: width * 0.63, child: _buildScrollAbleText(context, e.subingTeacherName, Border())),
                              
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.001,
                            child: Container(
                              decoration: BoxDecoration( 
                                color: Color(0xA0F0F0F0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.057,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(width: width * 0.63, child: _buildScrollAbleText(context, e.subjectName, Border(
                                right: BorderSide(color: Color(0x4FF0F0F0)),
                              ))),
                              SizedBox(width: width * 0.3, child: _buildScrollAbleText(context, e.roomName, Border()),),
                              ], 
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                
                ]
              ),
            ),
          ),
        );
  }

  static String _convertDate(DateTime date) {
    return "${date.year}.${date.month}.${date.day}";
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
          return Column(
            children: [
              SizedBox(height: height * 0.02),
              Text(_convertDate(subs[index][0][0].date), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xDFFFFFFF), fontSize: width * 0.08)),
              Container(
                margin: EdgeInsets.all(width * 0.01),
                decoration: BoxDecoration( 
                  color: Color(0x00000000),
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.005),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Helyettesítések ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xDFFFFFFF), fontSize: width * 0.06)),
                          
                        ],
                      ),
                      ...subs[index].map((e) => _buildTable(context, e)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
