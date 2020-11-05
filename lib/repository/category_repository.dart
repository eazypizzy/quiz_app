import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/repository/repository.dart';

class CategoryRepository {
  final TriviaApiClient triviaApiClient;

  CategoryRepository({@required this.triviaApiClient})
      : assert(triviaApiClient != null);

  Future<Category> getCategories() async {
    return triviaApiClient.fetchCategories();
  }
}
