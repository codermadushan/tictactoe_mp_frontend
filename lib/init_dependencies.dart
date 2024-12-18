import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'core/resources/socket_client.dart';
import 'features/game/bloc/game_bloc.dart';
import 'features/game/repositories/game_repository.dart';
import 'features/theme/bloc/theme_bloc.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(),
  );

  serviceLocator.registerLazySingleton<Socket>(
    () => SocketClient.instance.socket,
  );

  serviceLocator.registerFactory<GameRepository>(
    () => GameRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GameBloc>(
    () => GameBloc(serviceLocator()),
  );
}
