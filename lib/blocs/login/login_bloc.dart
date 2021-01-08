import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/validator.dart';
import 'package:rxdart/rxdart.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty());

  LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where(
        (event) => (event is! EmailChanged && event is! PasswordChanged));

    final debounceStream = observableStream
        .where((event) => (event is EmailChanged || event is PasswordChanged))
        .debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LogInWithGooglePressed) {
      yield* _mapLogInWithGooglePressedToState();
    } else if (event is LogInWithCredentialsPressed) {
      yield* _mapLogInWithCredentialsPressed(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield initialState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield initialState.update(
      isPassWordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLogInWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLogInWithCredentialsPressed(
      {String email, String password}) async* {
    try {
      yield LoginState.loading();
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
    }
  }
}
