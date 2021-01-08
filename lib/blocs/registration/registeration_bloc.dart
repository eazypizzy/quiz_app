import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registeration_event.dart';
part 'registeration_state.dart';

class RegisterationBloc extends Bloc<RegisterationEvent, RegisterationState> {
  RegisterationBloc() : super(RegisterationInitial());

  @override
  Stream<RegisterationState> mapEventToState(
    RegisterationEvent event,
  ) async* {}
}
