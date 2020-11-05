import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  int index = 0;

  TriviaBloc() : super(TriviaInitial(index: 0));

  @override
  Stream<TriviaState> mapEventToState(TriviaEvent event) async* {
    if (event is AnswerCLicked) {
      if (event.answer == event.correctAnswer) {
        yield AnswerCorrect();
      } else
        yield AnswerNotCorrect();
    }

    if (event is NoAnswerChosen) {
      yield ShowAnswer();
    }
  }
}
