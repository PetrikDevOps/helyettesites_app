import 'package:dio/dio.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/utils/constans/urls.dart';
import 'package:helyettesites/utils/data/subs.dart';

class SubModel {
    Dio dio = Dio();
    Future<List<Subs>> fetchSubs(User u) async {
    List<Subs> subs = [];


    var res = await Future.wait(u.url.map((e) => dio.get(Urls.baseUrl + Urls.substitution + e)));


    print(res);

    if (res.any((element) => element.statusCode != 200)) {
      return subs;
    }

    if ( res.any((element) => element.data["status"] != "success")) {
      return subs;
    }

    List<Subs> temp = [];

    res.forEach((element) {
      List<Subs> tables = (element.data["data"] as List).map((e) => Subs.fromJson(e)).toList();
      temp.addAll(tables);
    });

    return temp;
 }  
}
