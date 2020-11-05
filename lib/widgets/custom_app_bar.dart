import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xff2d4159),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff1f2538),
                    blurRadius: 10,
                    offset: Offset(1, 4),
                  )
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                      icon:
                          Icon(Icons.menu, size: 30, color: Color(0xffe2e4e7)),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Quiz App',
                        style:
                            TextStyle(color: Color(0xffe2e4e7), fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff4a5776),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff27394e),
                                offset: Offset(1, 1),
                                blurRadius: 4)
                          ]),
                      child: IconButton(
                        icon: Icon(Icons.person, color: Color(0xffe2e4e7)),
                        onPressed: () => null,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
