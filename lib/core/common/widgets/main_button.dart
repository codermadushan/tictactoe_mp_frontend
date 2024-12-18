import 'package:flutter/material.dart';

import '../../res/size_res.dart';

class MainButton extends StatelessWidget {
  final String _label;
  final VoidCallback _onTap;

  const MainButton({
    super.key,
    required String label,
    required VoidCallback onTap,
  })  : _label = label,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(57),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeRes.borderRadius),
        ),
      ),
      onPressed: _onTap,
      child: Text(
        _label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
