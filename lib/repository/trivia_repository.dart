import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:meta/meta.dart';

class TriviaRepository {
  final TriviaApiClient triviaApiClient;

  TriviaRepository({@required this.triviaApiClient})
      : assert(triviaApiClient != null);

  Future<Trivia> getQuestions(int categoryId) async {
    return triviaApiClient.fetchTrivias(categoryId);
  }

  Future<Trivia> getRandomQuestions() async {
    return triviaApiClient.fetchRandomTrivias();
  }
}
