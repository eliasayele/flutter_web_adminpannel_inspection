import 'package:flutter/material.dart';

///accept string and display it in snackbar
void showSnackBar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  final snackbar = SnackBar(
    backgroundColor: Colors.teal,
    content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
