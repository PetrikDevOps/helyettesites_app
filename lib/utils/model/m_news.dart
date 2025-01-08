import 'package:dio/dio.dart';
import 'package:helyettesites/utils/constans/urls.dart';
import 'package:helyettesites/utils/data/news.dart';

class NewsModel {
  Dio dio = Dio();
  Future<List<News>> fetchNews() async {
    List<News> news = [];
    var res = await dio.get(Urls.baseUrl + Urls.news);

    if (res.statusCode != 200) {
      return news;
    }
    if (res.data["status"] != "success") {
      return news;
    }
    news = (res.data["data"] as List).map((e) => News.fromJson(e)).toList();
    return news;
  }
}
