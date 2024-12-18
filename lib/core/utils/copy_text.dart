import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'show_snack_bar.dart';

Future<void> copyText({
  required BuildContext context,
  required String text,
}) async {
  final clipboardData = ClipboardData(text: text);
  await Clipboard.setData(clipboardData);
  if (context.mounted) {
    showSnackBar(
      context: context,
      message: 'Room ID is copied successfully',
    );
  }
}
