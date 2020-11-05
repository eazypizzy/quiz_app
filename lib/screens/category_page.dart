import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:quiz_app/blocs/trivia/trivia_bloc.dart';

import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:quiz_app/widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({Key key, this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      appBar: MyCustomAppBar(height: 100),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff242a40),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 400,
              child: ListView.builder(
                  itemCount: category.triviaCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          for (var cat in category.triviaCategories) {
                            if (cat.click) {
                              cat.click = false;
                            }
                          }
                          category.triviaCategories[index].click = true;
                          BlocProvider.of<CategoryBloc>(context).add(
                              QuizButtonClicked(
                                  categoryId:
                                      category.triviaCategories[index].id));
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff2f435b),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: BlocConsumer<CategoryBloc, CategoryState>(
                            listener: (context, state) {
                              if (state is FetchingQuestionsFailed) {
                                if (category.triviaCategories[index].click) {
                                  _key.currentState.showSnackBar(SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text(state.message)));
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is FetchingQuestionsInProgress) {
                                return ListTile(
                                    leading: (category
                                            .triviaCategories[index].click)
                                        ? null
                                        : Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CategoryImage(
                                                category: category
                                                    .triviaCategories[index]
                                                    .name,
                                                index: index),
                                          ),
                                    title: (category
                                            .triviaCategories[index].click)
                                        ? Loading()
                                        : Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              category
                                                  .triviaCategories[index].name,
                                              style: TextStyle(
                                                  color: Color(0xffe2e4e7),
                                                  fontSize: 15),
                                            ),
                                          ));
                              }
                              if (state is FetchingQuestionsSuccess) {
                                final questions = state.trivia;
                                Future.delayed(Duration.zero, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider<TriviaBloc>(
                                              create: (context) => TriviaBloc(),
                                            ),
                                            BlocProvider<CounterCubit>(
                                              create: (context) =>
                                                  CounterCubit(),
                                            )
                                          ],
                                          child:
                                              QuestionScreen(trivia: questions),
                                        );
                                      },
                                    ),
                                  );
                                });
                              }
                              return ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CategoryImage(
                                        category: category
                                            .triviaCategories[index].name,
                                        index: index),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      category.triviaCategories[index].name,
                                      style: TextStyle(
                                          color: Color(0xffe2e4e7),
                                          fontSize: 15),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
            child: InkWell(
                onTap: () {
                  BlocProvider.of<CategoryBloc>(context)
                      .add(RandomQuizButtonClicked());
                },
                child: BlocConsumer<CategoryBloc, CategoryState>(
                  listener: (context, state) {
                    if (state is RandomFailed) {
                      _key.currentState
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is RandominProgress) {
                      return Container(
                          alignment: Alignment.center,
                          child: Loading(),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff2f435b),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ));
                    }
                    if (state is RandomSuccess) {
                      final questions = state.trivia;
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider<TriviaBloc>(
                                create: (context) {
                                  return TriviaBloc();
                                },
                                child: QuestionScreen(trivia: questions),
                              );
                            },
                          ),
                        );
                      });
                    }
                    return Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Take a Random Quiz',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff2f435b),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ));
                  },
                )),
          ),
        ],
      ),
    );
  }
}
