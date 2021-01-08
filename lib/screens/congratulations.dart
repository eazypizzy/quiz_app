import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  final int finalScore;
  final int totalQuestions;

  const CongratulationsScreen({Key key, this.finalScore, this.totalQuestions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool success = (finalScore < 5);
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              child: Text(
                (success) ? 'Alaye! you no even try' : 'Gbayi! You Sabi',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: 150,
              width: 200,
              color: Colors.white,
              child: Image.asset(
                (success)
                    ? 'assets/images/crying.png'
                    : 'assets/images/welldone.png',
                height: 50,
                width: 100,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
                padding: EdgeInsets.all(5),
                height: 100,
                width: 200,
                decoration: BoxDecoration(color: Colors.green, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 2),
                    blurRadius: 4,
                  ),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Result',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$finalScore / $totalQuestions',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.accent,
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.accent,
                child: Text('LeaderBoard'),
                onPressed: () {},
              )
            ],
          ),
        )
      ]),
    );
  }
}
