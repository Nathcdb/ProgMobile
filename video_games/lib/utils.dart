import 'package:flutter/material.dart';

SizedBox space(double space) {
  return SizedBox(
    width: space,
    height: space,
  );
}

goto(Widget widget, BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

gotoNew(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Color blue = const Color.fromARGB(255, 26, 118, 193);
Color grey = const Color.fromARGB(255, 29, 36, 47);
