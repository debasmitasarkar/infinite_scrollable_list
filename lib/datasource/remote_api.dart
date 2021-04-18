import 'dart:convert';

import 'package:infinite_feed/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_feed/response/news_response.dart';

class RemoteApi {
  static Future<List<Article>> getArticleList(int pageNo, int pageSize) async {
    http.Response newsResponse = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&page=$pageNo&pageSize=$pageSize&apiKey=${AppConfig.apiKey}'));

    NewsResponse response =
        NewsResponse.fromJson(json.decode(newsResponse.body));
    return response.articles;
  }
}
