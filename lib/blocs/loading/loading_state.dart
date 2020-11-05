part of 'loading_bloc.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadingInitial extends LoadingState {}

class LoadingInProgress extends LoadingState {}

class LoadingSucess extends LoadingState {
  final Category category;

  LoadingSucess({@required this.category}) : assert(category != null);
  @override
  List<Object> get props => [category];
}

class LoadingFailed extends LoadingState {
  final String message;

  LoadingFailed({@required this.message});
  @override
  List<Object> get props => [message];
}
