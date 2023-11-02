import 'package:flutter/material.dart';

class ErrorEmptyFieldDialog extends StatelessWidget {
  const ErrorEmptyFieldDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text("Field were left empty"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
