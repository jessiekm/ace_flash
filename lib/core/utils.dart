import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.red, // You can change this to any color you prefer
        fontWeight: FontWeight.bold,
      ),
      child: Text(content),
    ),
  ));
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}
