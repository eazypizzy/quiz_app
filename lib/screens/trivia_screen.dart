import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/widgets/category_icons.dart';

class QuestionScreen extends StatefulWidget {
  final Trivia trivia;
  QuestionScreen({Key key, @required this.trivia})
      : assert(trivia != null),
        super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final trivia = widget.trivia;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(color: Color(0xff2d4159), boxShadow: [
                BoxShadow(
                  color: Color(0xff1f2538),
                  blurRadius: 10,
                  offset: Offset(1, 4),
                )
              ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 30,
                        child: CategoryImage(
                            category: trivia.results[0].category)),
                    SizedBox(width: 30),
                    Text(
                      trivia.results[0].category,
                      style: TextStyle(
                          color: Color(0xffe2e4e7),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Timer(),
            SizedBox(height: 5),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                var item = trivia.results[state].answers;
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                trivia.results[state].question,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          child: ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    for (var ans in item) {
                                      if (ans.click) {
                                        ans.click = false;
                                      }
                                    }
                                    item[index].click = true;
                                    BlocProvider.of<TriviaBloc>(context)
                                        .add(AnswerCLicked(
                                      answer: item[index].answer,
                                      correctAnswer:
                                          trivia.results[state].correctAnswer,
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8),
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Color(0xffe2e4e7),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(22.5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item[index].answer,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        BlocBuilder<TriviaBloc, TriviaState>(
                                          builder: (context, state) {
                                            if (state is AnswerCorrect) {
                                              return Container(
                                                width: 50,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(2, 2),
                                                        blurRadius: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.4),
                                                      )
                                                    ]),
                                                child: (item[index].click)
                                                    ? Icon(Icons.done,
                                                        color: Colors.blue,
                                                        size: 20)
                                                    : null,
                                              );
                                            }
                                            if (state is AnswerNotCorrect) {
                                              return Container(
                                                width: 50,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(2, 2),
                                                        blurRadius: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.3),
                                                      )
                                                    ]),
                                                child: (item[index].click)
                                                    ? Icon(Icons.cancel,
                                                        color: Colors.red,
                                                        size: 20)
                                                    : null,
                                              );
                                            }
                                            return Container(
                                              width: 50,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(2, 4),
                                                    blurRadius: 1,
                                                    color: Colors.grey
                                                        .withOpacity(.3),
                                                  )
                                                ],
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () => context.bloc<CounterCubit>().increment(),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xffe2e4e7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                )),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountDownController _controller = CountDownController();
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        if (state != 0) {
          _controller.restart();
        }
        return Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircularCountDownTimer(
              controller: _controller,
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
        );
      },
    );
  }
}
