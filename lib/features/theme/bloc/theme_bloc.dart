import 'package:flutter/foundation.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  static const _key = 'isDark';

  ThemeBloc() : super(ThemeLight()) {
    on<ThemeToggle>(_themeToggle);
  }

  void _themeToggle(ThemeToggle event, Emitter<ThemeState> emit) {
    emit(state is ThemeLight ? ThemeDark() : ThemeLight());
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final isDark = json[_key];
    if (isDark == true) return ThemeDark();
    return ThemeLight();
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {_key: state is ThemeDark};
  }
}
