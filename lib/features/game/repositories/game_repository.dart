import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/utils/check_winner.dart';
import '../bloc/game_bloc.dart';
import '../models/room_model.dart';

class GameRepository {
  final Socket _socket;

  const GameRepository(Socket socket) : _socket = socket;

  String get socketId {
    return _socket.id!;
  }

  // Emit Events
  void createRoom(String nickname) {
    _socket.emit('create-room', {'nickname': nickname});
  }

  void joinRoom({
    required String nickname,
    required String roomId,
  }) {
    _socket.emit('join-room', {
      'nickname': nickname,
      'roomId': roomId,
    });
  }

  void tapOnCell({
    required List<String> cellValues,
    required String roomId,
    required int index,
  }) {
    if (cellValues[index].isNotEmpty) return;
    _socket.emit('tap-on-cell', {
      'roomId': roomId,
      'index': index,
    });
  }

  void checkForWinner({
    required String roomId,
    required List<String> cellValues,
  }) {
    final winner = checkWinner(cellValues);
    if (winner == null) {
      _socket.emit('draw-the-game', {'roomId': roomId});
    } else if (winner != '') {
      _socket.emit('win-the-game', {'roomId': roomId, 'winner': winner});
    }
  }

  // Activate listeners
  void activateCreateRoomSuccessListener(GameBloc gameBloc) {
    _socket.on('create-room-success', (roomId) {
      gameBloc.add(GameCreateRoomSuccess(roomId));
    });
  }

  void activateJoinRoomSuccessListener(GameBloc gameBloc) {
    _socket.on('join-room-success', (roomData) {
      final room = RoomModel.fromMap(roomData);
      gameBloc.add(GameJoinRoomSuccess(room));
    });
  }

  void activateTappedOnCellListener(GameBloc gameBloc) {
    _socket.on('tapped-on-cell', (data) {
      final room = RoomModel.fromMap(data['roomData']);
      gameBloc.add(GameTappedOnCell(
        room: room,
        index: data['index'],
        choice: data['choice'],
      ));
    });
  }

  void activateDrawGameListener(GameBloc gameBloc) {
    _socket.on('draw-game', (roomData) {
      final room = RoomModel.fromMap(roomData);
      gameBloc.add(GameDrawGame(room));
    });
  }

  void activateWinGameListener(GameBloc gameBloc) {
    _socket.on('win-game', (data) {
      final room = RoomModel.fromMap(data['room']);
      final message = data['message'];
      gameBloc.add(GameWinGame(room: room, message: message));
    });
  }

  void activateEndGameListener(GameBloc gameBloc) {
    _socket.on('end-game', (data) {
      final room = RoomModel.fromMap(data['room']);
      final message = data['message'];
      gameBloc.add(GameEndGame(
        room: room,
        message: message,
      ));
    });
  }

  void activateErrorListener(GameBloc gameBloc) {
    _socket.on('server-error', (message) {
      gameBloc.add(GameServerError(message));
    });
  }
}
