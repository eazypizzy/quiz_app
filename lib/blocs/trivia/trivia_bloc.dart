import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  TriviaBloc({@required this.controller}) : super(TriviaInitial());
  final CountDownController controller;

  Stream<TriviaState> mapEventToState(TriviaEvent event) async* {
    if (event is AnswerCLicked) {
      if (event.answer == event.correctAnswer) {
        yield AnswerCorrect();
      } else {
        yield AnswerNotCorrect();
      }
    }
    if (event is NoAnswerChosen) {
      yield ShowAnswer();
    }

    if (event is NextQuestion) {
      print('index is ${event.cIndex}');

      if (event.cIndex > 9) {
        await Future.delayed(Duration.zero);
        yield QuestionsFinished();
      } else {
        yield ShowNextQuestion();
        yield TriviaInitial();
      }
    }
  }
}
