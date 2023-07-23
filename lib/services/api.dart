import 'package:dio/dio.dart';
import 'package:quiz_app_flutter/models/category.dart';
import 'package:quiz_app_flutter/models/questions.dart';

class Api {
  static Future<List<Category>?> getCategories() async {
    try {
      var response = await Dio().get("https://opentdb.com/api_category.php");
      final categories = (response.data["trivia_categories"] as List<dynamic>)
          .map((e) => Category.fromMap(e))
          .toList();
      return categories;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Questions>?> getQuestions(int categoryId, int numberOfCount) async {
    try {
      var response = await Dio().get(
          "https://opentdb.com/api.php?amount=$numberOfCount&category=$categoryId&type=multiple");
      final questions =
          (response.data["results"] as List<dynamic>).map((e) => Questions.fromMap(e)).toList();
      return questions;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
