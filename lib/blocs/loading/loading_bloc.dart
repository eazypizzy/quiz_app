import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/models.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/repository/repository.dart';
part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final CategoryRepository categoryRepository;
  LoadingBloc({@required this.categoryRepository})
      : assert(categoryRepository != null),
        super(LoadingInitial());

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    if (event is AppLoaded) {
      yield LoadingInProgress();
      try {
        await Future.delayed(Duration(milliseconds: 10));
        final category = await categoryRepository.getCategories();
        yield LoadingSucess(category: category);
      } catch (e) {
        print(e);
        yield LoadingFailed(message: 'Oops! check your connectivity');
      }
    }
  }
}
