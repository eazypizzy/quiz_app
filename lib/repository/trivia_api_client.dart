import 'dart:convert';
import 'dart:math';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/models.dart';

class TriviaApiClient {
  static const baseUrl = 'https://opentdb.com/api.php';
  final http.Client httpClient;

  TriviaApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Category> fetchCategories() async {
    final categoryUrl = 'https://opentdb.com/api_category.php';
    try {
      final categoryResponse = await httpClient.get(categoryUrl);
      if (categoryResponse.statusCode != 200) {
        print(categoryResponse.statusCode);
        throw Exception('error fetching categories');
      }
      final categoryJson = jsonDecode(categoryResponse.body);
      return Category.fromJson(categoryJson);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Trivia> fetchTrivias(int categoryId) async {
    int randomNumber = Random().nextInt(50) + 20;
    var triviaUrl;
    print('id is $categoryId');
    triviaUrl = '$baseUrl?amount=$randomNumber&category=$categoryId';

    try {
      final triviaResponse = await httpClient.get(triviaUrl);
      print(triviaUrl);
      if (triviaResponse.statusCode != 200) {
        print(triviaResponse.statusCode);
        throw Exception('could not fetch questions');
      }
      final triviaJson = jsonDecode(triviaResponse.body);

      return Trivia.fromJson(triviaJson);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Trivia> fetchRandomTrivias() async {
    int randomNumber = Random().nextInt(50) + 20;
    var triviaUrl;
    triviaUrl = '$baseUrl?amount=$randomNumber';
    try {
      final triviaResponse = await httpClient.get(triviaUrl);
      print(triviaUrl);
      if (triviaResponse.statusCode != 200) {
        print(triviaResponse.statusCode);
        throw Exception('could not fetch questions');
      }
      final triviaJson = jsonDecode(triviaResponse.body);

      return Trivia.fromJson(triviaJson);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
