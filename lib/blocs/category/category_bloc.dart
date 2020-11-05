import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:meta/meta.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final TriviaRepository repo;
  CategoryBloc({@required this.repo})
      : assert(repo != null),
        super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is QuizButtonClicked) {
      yield FetchingQuestionsInProgress();
      try {
        await Future.delayed(Duration(milliseconds: 500));
        final questions = await repo.getQuestions(event.categoryId);
        print(questions.results[0].correctAnswer);
        print(questions.results[0].allAnswers);
        yield FetchingQuestionsSuccess(trivia: questions);
      } catch (e) {
        print(e);
        yield FetchingQuestionsFailed(message: 'error fetching questions');
      }
    }
    if (event is RandomQuizButtonClicked) {
      yield RandominProgress();
      try {
        await Future.delayed(Duration(milliseconds: 500));
        final questions = await repo.getRandomQuestions();

        yield RandomSuccess(trivia: questions);
      } catch (e) {
        print(e);

        yield RandomFailed(message: 'error fetching random questions');
        yield CategoryInitial();
      }
    }
  }
}
