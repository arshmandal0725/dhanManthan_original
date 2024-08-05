import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dhanmanthan_original/models/news_category.dart';

class NewsCategoryRepository {
  Future<NewsCategory> getCategoryData() async {
    String url =
        'https://newsapi.org/v2/everything?q=business&apiKey=e39a1b24c0d04489b1e1f6512f8f1488';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      return NewsCategory.fromJson(body);
    }
    throw Error();
  }
}
