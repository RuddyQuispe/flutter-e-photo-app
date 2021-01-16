import 'package:flutter/material.dart';

void makeDialog({BuildContext context, String message = "await pleace"}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
            title: Text(message),
            content: LinearProgressIndicator(
                backgroundColor: Colors.deepPurple[600]),
          ));
}
