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

  AnswerCLicked({this.correctAnswer, this.index, this.answer});
  @override
  List<Object> get props => [answer];
}

class NoAnswerChosen extends TriviaEvent {}

class SubmitClicked extends TriviaEvent {}
