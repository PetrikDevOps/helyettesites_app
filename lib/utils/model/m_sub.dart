import 'package:dio/dio.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/utils/constans/urls.dart';
import 'package:helyettesites/utils/data/subs.dart';

class SubModel {
  Dio dio = Dio();
  Future<List<Subs>> fetchSubs(User u) async {
    List<Subs> subs = [];

    var res = await Future.wait(
        u.url.map((e) => dio.get(Urls.baseUrl + Urls.substitution + e)));

    if (res.any((element) => element.statusCode != 200)) {
      return subs;
    }

    if (res.any((element) => element.data["status"] != "success")) {
      return subs;
    }

    List<Subs> temp = [];

    for (var i = 0; i < res.length; i++) {
      List<Subs> tables =
          (res[i].data["data"] as List).map((e) => Subs.fromJson(e)).toList();
      temp.addAll(tables);
    }

    return temp;
  }
}
