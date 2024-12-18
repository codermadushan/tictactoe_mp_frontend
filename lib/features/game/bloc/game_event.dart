part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class GamePlayAgain extends GameEvent {}

// Emit events
@immutable
final class GameCreateRoom extends GameEvent {
  final String nickname;

  GameCreateRoom(this.nickname);
}

@immutable
final class GameJoinRoom extends GameEvent {
  final String nickname;
  final String roomId;

  GameJoinRoom({
    required this.nickname,
    required this.roomId,
  });
}

@immutable
final class GameTapOnCell extends GameEvent {
  final String roomId;
  final int index;

  GameTapOnCell({
    required this.roomId,
    required this.index,
  });
}

// Get data from listeners
@immutable
final class GameCreateRoomSuccess extends GameEvent {
  final String roomId;

  GameCreateRoomSuccess(this.roomId);
}

@immutable
final class GameJoinRoomSuccess extends GameEvent {
  final RoomModel room;

  GameJoinRoomSuccess(this.room);
}

@immutable
final class GameTappedOnCell extends GameEvent {
  final RoomModel room;
  final int index;
  final String choice;

  GameTappedOnCell({
    required this.room,
    required this.index,
    required this.choice,
  });
}

@immutable
final class GameDrawGame extends GameEvent {
  final RoomModel room;

  GameDrawGame(this.room);
}

@immutable
final class GameWinGame extends GameEvent {
  final RoomModel room;
  final String message;

  GameWinGame({
    required this.room,
    required this.message,
  });
}

@immutable
final class GameEndGame extends GameEvent {
  final RoomModel room;
  final String message;

  GameEndGame({
    required this.room,
    required this.message,
  });
}

@immutable
final class GameServerError extends GameEvent {
  final String message;

  GameServerError(this.message);
}

// Activate listeners
final class GameActivateCreateRoomSuccessListener extends GameEvent {}

final class GameActivateJoinRoomSuccessListener extends GameEvent {}

final class GameActivateTappedOnCellListener extends GameEvent {}

final class GameActivateDrawGameListener extends GameEvent {}

final class GameActivateWinGameListener extends GameEvent {}

final class GameActivateEndGameListener extends GameEvent {}

final class GameActivateServerErrorListener extends GameEvent {}
