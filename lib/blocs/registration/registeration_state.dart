part of 'registeration_bloc.dart';

abstract class RegisterationState extends Equatable {
  const RegisterationState();
  
  @override
  List<Object> get props => [];
}

class RegisterationInitial extends RegisterationState {}
