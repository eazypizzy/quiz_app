import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key key, this.icon, this.color}) : super(key: key);
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[700],
              offset: Offset(1, 1),
              blurRadius: 4,
            )
          ]),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
