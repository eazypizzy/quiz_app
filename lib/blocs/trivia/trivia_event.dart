part of 'trivia_bloc.dart';

abstract class TriviaEvent extends Equatable {
  const TriviaEvent();

  @override
  List<Object> get props => [];
}

class AnswerCLicked extends TriviaEvent {
  final String answer;
  final int index;
  final String correctAnswer;
  final List<String> allAnswers;

  AnswerCLicked({this.correctAnswer, this.index, this.answer, this.allAnswers});
  @override
  List<Object> get props => [answer];
}

class NoAnswerChosen extends TriviaEvent {}

class NextQuestion extends TriviaEvent {
  final int cIndex;

  NextQuestion({this.cIndex});
  @override
  List<Object> get props => [cIndex];
}
