import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/blocs.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool get isPopulated => _email.text.isNotEmpty && _password.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _email.addListener(() {});
    _password.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome\nBack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your details to gain access\nto your account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        FormField(
                          controller: _email,
                          icon: Icons.email,
                          label: 'Email',
                          validate:
                              (!state.isEmailValid) ? 'Email Invalid' : null,
                        ),
                        SizedBox(height: 10),
                        FormField(
                          controller: _password,
                          icon: Icons.lock,
                          label: 'Password',
                          validate: (!state.isPasswordValid)
                              ? 'Password Invalid'
                              : null,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(),
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    Key key,
    this.label,
    this.icon,
    this.validate,
    this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(icon),
          labelText: label,
        ),
        autovalidateMode: AutovalidateMode.always,
        autocorrect: false,
        validator: (value) => validate,
      ),
    );
  }
}
