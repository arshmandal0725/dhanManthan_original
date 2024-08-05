import 'package:dhanmanthan_original/models/news_category.dart';
import 'package:dhanmanthan_original/api/news_category_repository.dart';


class NewsCategoryViewModel {
  final _rep = NewsCategoryRepository();

  Future<NewsCategory> getCategoryData() async {
    final response = await _rep.getCategoryData();
    return response;
  }
}
