import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/screens/congratulations.dart';
import 'package:quiz_app/widgets/category_icons.dart';
import 'package:quiz_app/widgets/widgets.dart';

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
    var click = false;
    final trivia = widget.trivia;
    int ind = 0;
    var score = 0;
    var unescape = HtmlUnescape();
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
            BlocConsumer<TriviaBloc, TriviaState>(
              listener: (context, state) {
                if (state is TriviaInitial) {
                  click = false;
                }
                if (state is ShowAnswer) {
                  click = true;
                }

                if (state is AnswerCorrect) {
                  score = score + 1;
                }
              },
              builder: (context, state) {
                var item = trivia.results[ind];
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
                                unescape.convert(item.question),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
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
                            itemCount: item.answers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IgnorePointer(
                                  ignoring: click,
                                  child: InkWell(
                                    onTap: () {
                                      click = true;
                                      item.answers[index].click = true;
                                      BlocProvider.of<TriviaBloc>(context)
                                          .add(AnswerCLicked(
                                        allAnswers: item.allAnswers,
                                        answer: item.answers[index].answer,
                                        correctAnswer: item.correctAnswer,
                                      ));
                                    },
                                    child: BlocBuilder<TriviaBloc, TriviaState>(
                                        builder: (context, state) {
                                      if (state is ShowAnswer) {
                                        return Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: (item.answers[index]
                                                        .answer ==
                                                    item.correctAnswer)
                                                ? Colors.green.withOpacity(.3)
                                                : Color(0xffe2e4e7),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(22.5),
                                            ),
                                          ),
                                          child: (item.answers[index].answer ==
                                                  item.correctAnswer)
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      text: unescape.convert(
                                                          item.answers[index]
                                                              .answer),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Indicator(
                                                          color: Colors.green,
                                                          icon: Icons.check),
                                                    )
                                                  ],
                                                )
                                              : IncorrectAnswer(
                                                  text: unescape.convert(item
                                                      .answers[index].answer),
                                                ),
                                        );
                                      }
                                      if (state is AnswerCorrect) {
                                        return Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: (item.answers[index].click)
                                                ? Colors.green.withOpacity(.3)
                                                : Color(0xffe2e4e7),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(22.5),
                                            ),
                                          ),
                                          child: (item.answers[index].click)
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      text: unescape.convert(
                                                          item.answers[index]
                                                              .answer),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Indicator(
                                                          color: Colors.green,
                                                          icon: Icons.check),
                                                    )
                                                  ],
                                                )
                                              : IncorrectAnswer(
                                                  text: unescape.convert(item
                                                      .answers[index].answer),
                                                ),
                                        );
                                      }
                                      if (state is AnswerNotCorrect) {
                                        return Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: (item.answers[index].click)
                                                ? Colors.red.withOpacity(.3)
                                                : Color(0xffe2e4e7),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(22.5),
                                            ),
                                          ),
                                          child: (item.answers[index].click)
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      text: unescape.convert(
                                                          item.answers[index]
                                                              .answer),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green
                                                              .withOpacity(.5),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              unescape.convert(item
                                                                  .correctAnswer),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Indicator(
                                                          color: Colors.red,
                                                          icon: Icons.cancel),
                                                    )
                                                  ],
                                                )
                                              : IncorrectAnswer(
                                                  text: unescape.convert(item
                                                      .answers[index].answer),
                                                ),
                                        );
                                      }
                                      if (state is QuestionsFinished) {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CongratulationsScreen(
                                                finalScore: score,
                                                totalQuestions:
                                                    trivia.results.length);
                                          }));
                                        });
                                      }
                                      return Container(
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
                                              unescape.convert(
                                                  item.answers[index].answer),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ]);
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 17),
              child: BlocConsumer<TriviaBloc, TriviaState>(
                  listener: (context, state) {
                if (state is ShowNextQuestion) {
                  ind = ind + 1;
                }
              }, builder: (context, state) {
                return Next(
                  cIndex: ind + 1,
                  text: (ind == 9) ? 'Submit' : 'Next',
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
