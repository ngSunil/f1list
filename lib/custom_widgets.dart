import 'package:flutter/material.dart';

class CustomWidgets {
  CustomWidgets._();
  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message"),
      ),
    );
  }
}
