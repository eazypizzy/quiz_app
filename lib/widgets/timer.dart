import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/blocs.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TriviaBloc, TriviaState>(
      listener: (context, state) {
        if (state is ShowNextQuestion) {
          context.bloc<TriviaBloc>().controller.restart();
        }
        if (state is AnswerCorrect || state is AnswerNotCorrect) {
          context.bloc<TriviaBloc>().controller.pause();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: CircularCountDownTimer(
            controller: context.bloc<TriviaBloc>().controller,
            isReverse: true,
            isReverseAnimation: true,
            width: 75,
            height: 75,
            textStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            duration: 30,
            fillColor: Color(0xffe6812f),
            color: Colors.white,
            onComplete: () =>
                BlocProvider.of<TriviaBloc>(context).add(NoAnswerChosen()),
          ),
        ),
      ),
    );
  }
}
