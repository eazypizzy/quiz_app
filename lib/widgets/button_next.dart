import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Next extends StatelessWidget {
  final int cIndex;
  final String text;
  const Next({Key key, this.cIndex, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.bloc<TriviaBloc>().add(NextQuestion(cIndex: cIndex));
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xffe2e4e7),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
