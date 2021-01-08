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
  runApp(Quiz(apiClient: apiClient));
}

class Quiz extends StatefulWidget {
  final TriviaApiClient apiClient;
  Quiz({Key key, this.apiClient}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(userRepo: userRepo)..add(AppStarted()),
      child: MaterialApp(
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              BlocProvider.of<LoadingBloc>(context).add(AppLoaded());
            }
          },
          builder: (context, state) {
            if (state is Uninitialized) {
              return Splash();
            }
            if (state is Authenticated) {
              return BlocProvider<LoadingBloc>(
                create: (context) {
                  final apiClient = widget.apiClient;
                  final catRepo =
                      CategoryRepository(triviaApiClient: apiClient);
                  return LoadingBloc(categoryRepository: catRepo);
                },
                child: CategoryScreen(),
              );
            }
            if (state is Uninitialized) {
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: userRepo),
                child: LoginScreen(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

// class QuizApp extends StatelessWidget {
//   final TriviaApiClient client;
//   const QuizApp({
//     Key key,
//     @required this.client,
//   })  : assert(client != null),
//         super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quiz App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xff242a40),
//         primaryColor: Color(0xffe2e4e7),
//       ),
//       home: RepositoryProvider(
//         create: (context) => CategoryRepository(triviaApiClient: client),
//         child: BlocProvider<LoadingBloc>(
//           create: (context) {
//             final categoryRepo =
//                 RepositoryProvider.of<CategoryRepository>(context);
//             return LoadingBloc(categoryRepository: categoryRepo)
//               ..add(AppLoaded());
//           },
//           child: SplashScreen(),
//         ),
//       ),
//     );
//   }
// }
