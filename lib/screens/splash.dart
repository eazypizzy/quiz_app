import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          if (state is LoadingSucess) {
            final category = state.category;
            Future.delayed(Duration.zero, () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute<CategoryScreen>(
                builder: (context) {
                  return RepositoryProvider<TriviaRepository>(
                    create: (context) {
                      final client = TriviaApiClient(httpClient: http.Client());
                      return TriviaRepository(triviaApiClient: client);
                    },
                    child: BlocProvider<CategoryBloc>(
                      create: (context) {
                        final triviaRepo =
                            RepositoryProvider.of<TriviaRepository>(context);
                        return CategoryBloc(repo: triviaRepo);
                      },
                      child: CategoryScreen(category: category),
                    ),
                  );
                },
              ));
            });
          }
          if (state is LoadingFailed) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    textTheme: ButtonTextTheme.accent,
                    child: Text('Retry'),
                    onPressed: () {
                      BlocProvider.of<LoadingBloc>(context).add(AppLoaded());
                    },
                  )
                ],
              )),
            );
          }
          if (state is LoadingInProgress) {
            return SplashLoading();
          }
          return Splash();
        },
      )),
    );
  }
}

class SplashLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Splash(),
        Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 30),
            child: SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
            ))
      ],
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Image.asset('assets/icons/logo.jpg', width: 150, height: 150),
      ),
    );
  }
}
