part of 'trivia_bloc.dart';

abstract class TriviaState extends Equatable {
  const TriviaState();

  @override
  List<Object> get props => [];
}

class TriviaInitial extends TriviaState {
  final int index;
  TriviaInitial({@required this.index});
  @override
  List<Object> get props => [index];
}

class NextQuestion extends TriviaState {}

class AnswerCorrect extends TriviaState {}

class AnswerNotCorrect extends TriviaState {}

class ShowAnswer extends TriviaState {}

class QuestionsFinished extends TriviaState {}
