part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailCHanged(email: $email)';
  }
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'PasswordChanged(password: $password)';
  }
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted(email: $email,password: $password)';
  }
}

class LogInWithGooglePressed extends LoginEvent {
  @override
  String toString() {
    return 'LogInWithGooglePressed';
  }
}

class LogInWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LogInWithCredentialsPressed({@required this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LogInWithCredentialsPressed(email: $email,password: $password)';
  }
}
