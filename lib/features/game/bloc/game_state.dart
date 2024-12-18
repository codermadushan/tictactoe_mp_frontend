part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

@immutable
final class GameLobby extends GameState {
  final String roomId;

  GameLobby(this.roomId);
}

@immutable
final class GamePlay extends GameState {
  final RoomModel room;
  final List<String> cellValues;
  final String mySocketId;

  GamePlay({
    required this.room,
    required this.cellValues,
    required this.mySocketId,
  });
}

@immutable
final class GameDraw extends GameState {
  final RoomModel room;
  final List<String> cellValues;
  final String mySocketId;

  GameDraw({
    required this.room,
    required this.cellValues,
    required this.mySocketId,
  });
}

@immutable
final class GameWin extends GameState {
  final RoomModel room;
  final String message;
  final List<String> cellValues;
  final String mySocketId;

  GameWin({
    required this.room,
    required this.message,
    required this.cellValues,
    required this.mySocketId,
  });
}

@immutable
final class GameEnd extends GameState {
  final RoomModel room;
  final String message;
  final List<String> cellValues;
  final String mySocketId;

  GameEnd({
    required this.room,
    required this.message,
    required this.cellValues,
    required this.mySocketId,
  });
}

@immutable
final class GameError extends GameState {
  final String message;

  GameError(this.message);
}
