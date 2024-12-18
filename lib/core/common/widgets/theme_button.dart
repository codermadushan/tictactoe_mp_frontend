import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/theme/bloc/theme_bloc.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read<ThemeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state is ThemeDark;
        return IconButton(
          onPressed: () {
            _themeBloc.add(ThemeToggle());
          },
          icon: Icon(isDark ? Icons.sunny : Icons.brightness_2_rounded),
        );
      },
    );
  }
}
