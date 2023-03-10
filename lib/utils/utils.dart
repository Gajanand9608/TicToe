import 'package:flutter/material.dart';
import 'package:tictoe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(BuildContext context, String content) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                GameMethods().clearBoard(context);
                Navigator.of(context).pop();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      });
}
