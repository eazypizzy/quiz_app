part of 'trivia_bloc.dart';

abstract class TriviaState extends Equatable {
  const TriviaState();

  @override
  List<Object> get props => [];
}

class TriviaInitial extends TriviaState {}

class AnswerCorrect extends TriviaState {}

class AnswerNotCorrect extends TriviaState {}

class ShowAnswer extends TriviaState {}

class ShowNextQuestion extends TriviaState {}

class QuestionsFinished extends TriviaState {}
