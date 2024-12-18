import 'package:flutter/material.dart';

import '../../features/game/pages/create_room_page.dart';
import '../../features/game/pages/game_page/game_page.dart';
import '../../features/game/pages/join_room_page.dart';
import '../../features/game/pages/lobby_page.dart';
import '../../features/game/pages/menu_page.dart';

sealed class AppRoute {
  static const menuPage = '/menu-page';
  static const createRoomPage = '/create-room-page';
  static const joinRoomPage = '/join-room-page';
  static const lobbyPage = '/lobby-page';
  static const gamePage = '/game-page';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      menuPage: (context) => const MenuPage(),
      createRoomPage: (context) => const CreateRoomPage(),
      joinRoomPage: (context) => const JoinRoomPage(),
      lobbyPage: (context) => const LobbyPage(),
      gamePage: (context) => const GamePage(),
    };
  }
}
