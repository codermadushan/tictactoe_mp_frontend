import 'package:flutter/material.dart';

void popDialog({
  required BuildContext context,
  required String message,
  required String buttonLabel,
  required VoidCallback onTap,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: PopScope(
          canPop: false,
          child: Text(message),
        ),
        actions: [
          TextButton(
            onPressed: onTap,
            child: Text(buttonLabel),
          ),
        ],
      );
    },
  );
}
