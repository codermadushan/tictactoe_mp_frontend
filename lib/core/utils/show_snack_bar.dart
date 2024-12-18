import 'package:flutter/material.dart';

enum SnackBarType { error, info }

void showSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.info,
}) {
  final errorColor = Theme.of(context).colorScheme.error;
  final snackBar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    backgroundColor: type == SnackBarType.error ? errorColor : null,
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
