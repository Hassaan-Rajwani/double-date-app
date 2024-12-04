import 'package:flutter/material.dart';

Container spinkit = Container(
  padding: const EdgeInsets.all(10),
  child: Image.asset(
    'assets/png/loader.gif',
    color: Colors.pink,
  ),
);

dialogSpinkit({required BuildContext context}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return spinkit;
    },
  );
}
