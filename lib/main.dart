import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/screens/screens.dart';
import 'custom_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final apiClient = TriviaApiClient(httpClient: http.Client());
  runApp(QuizApp(client: apiClient));
}

class QuizApp extends StatelessWidget {
  final TriviaApiClient client;
  const QuizApp({
    Key key,
    @required this.client,
  })  : assert(client != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff242a40),
        primaryColor: Color(0xffe2e4e7),
      ),
      home: RepositoryProvider(
        create: (context) => CategoryRepository(triviaApiClient: client),
        child: BlocProvider<LoadingBloc>(
          create: (context) {
            final categoryRepo =
                RepositoryProvider.of<CategoryRepository>(context);
            return LoadingBloc(categoryRepository: categoryRepo)
              ..add(AppLoaded());
          },
          child: SplashScreen(),
        ),
      ),
    );
  }
}
