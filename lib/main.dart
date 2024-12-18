import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/routes/app_route.dart';
import 'features/game/bloc/game_bloc.dart';
import 'features/theme/bloc/theme_bloc.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<ThemeBloc>()),
        BlocProvider(create: (context) => serviceLocator<GameBloc>()),
      ],
      child: const TicTacToeMP(),
    ),
  );
}

class TicTacToeMP extends StatelessWidget {
  const TicTacToeMP({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FlexThemeData.light(scheme: FlexScheme.cyanM3),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.cyanM3),
          themeMode: state is ThemeDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppRoute.menuPage,
          routes: AppRoute.routes,
        );
      },
    );
  }
}
