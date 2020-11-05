part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class QuizButtonClicked extends CategoryEvent {
  final int categoryId;

  QuizButtonClicked({this.categoryId});
}

class RandomQuizButtonClicked extends CategoryEvent {}
