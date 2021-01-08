import 'dart:ui';

import 'package:flutter/material.dart';

class IncorrectAnswer extends StatelessWidget {
  const IncorrectAnswer({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(22.5)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.black.withOpacity(.03),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
