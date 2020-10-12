import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_bloc_app/constants/Strings.dart';
import 'package:news_bloc_app/models/NewsModel.dart';

// ignore: camel_case_types
class API_Manager {
  static Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.news_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}