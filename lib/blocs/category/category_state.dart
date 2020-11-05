part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class FetchingQuestionsInProgress extends CategoryState {}

class RandominProgress extends CategoryState {}

class FetchingQuestionsSuccess extends CategoryState {
  final Trivia trivia;

  FetchingQuestionsSuccess({@required this.trivia}) : assert(trivia != null);
  @override
  List<Object> get props => [trivia];
}

class RandomSuccess extends CategoryState {
  final Trivia trivia;

  RandomSuccess({@required this.trivia}) : assert(trivia != null);
  @override
  List<Object> get props => [trivia];
}

class FetchingQuestionsFailed extends CategoryState {
  final String message;

  FetchingQuestionsFailed({@required this.message});
  @override
  List<Object> get props => [message];
}

class RandomFailed extends CategoryState {
  final String message;

  RandomFailed({@required this.message});
  @override
  List<Object> get props => [message];
}
