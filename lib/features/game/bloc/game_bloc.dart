import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/room_model.dart';
import '../repositories/game_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static final _cellValues = ['', '', '', '', '', '', '', '', ''];

  final GameRepository _gameRepository;

  GameBloc(GameRepository gameRepository)
      : _gameRepository = gameRepository,
        super(GameInitial()) {
    on<GamePlayAgain>(_gamePlayAgain);

    // Emit events
    on<GameCreateRoom>(_gameCreateRoom);
    on<GameJoinRoom>(_gameJoinRoom);
    on<GameTapOnCell>(_gameTapOnCell);

    // Get data from listeners
    on<GameCreateRoomSuccess>(_gameCreateRoomSuccess);
    on<GameJoinRoomSuccess>(_gameJoinRoomSuccess);
    on<GameTappedOnCell>(_gameTappedOnCell);
    on<GameDrawGame>(_gameDrawGame);
    on<GameWinGame>(_gameWinGame);
    on<GameEndGame>(_gameEndGame);
    on<GameServerError>(_gameServerError);

    // Activate listeners
    on<GameActivateCreateRoomSuccessListener>(
      _gameActivateCreateRoomSuccessListener,
    );
    on<GameActivateJoinRoomSuccessListener>(
      _gameActivateJoinRoomSuccessListener,
    );
    on<GameActivateTappedOnCellListener>(
      _gameActivateTappedOnCellListener,
    );
    on<GameActivateDrawGameListener>(_gameActivateDrawGameListener);
    on<GameActivateWinGameListener>(_gameActivateWinGameListener);
    on<GameActivateEndGameListener>(_gameActivateEndGameListener);
    on<GameActivateServerErrorListener>(_gameActivateServerErrorListener);
  }

  void _clearCellValues() {
    for (var i = 0; i < 9; i++) {
      _cellValues[i] = '';
    }
  }

  void _gamePlayAgain(GamePlayAgain event, Emitter<GameState> emit) {
    _clearCellValues();
    if (state is GameDraw) {
      final gameDrawState = (state as GameDraw);
      emit(GamePlay(
        room: gameDrawState.room,
        cellValues: _cellValues,
        mySocketId: _gameRepository.socketId,
      ));
    }
    if (state is GameWin) {
      final gameWinState = (state as GameWin);
      emit(GamePlay(
        room: gameWinState.room,
        cellValues: _cellValues,
        mySocketId: _gameRepository.socketId,
      ));
    }
  }

  // Emit events
  void _gameCreateRoom(GameCreateRoom event, Emitter<GameState> emit) {
    _gameRepository.createRoom(event.nickname);
  }

  void _gameJoinRoom(GameJoinRoom event, Emitter<GameState> emit) {
    _gameRepository.joinRoom(
      nickname: event.nickname,
      roomId: event.roomId,
    );
  }

  void _gameTapOnCell(GameTapOnCell event, Emitter<GameState> emit) {
    _gameRepository.tapOnCell(
      cellValues: _cellValues,
      roomId: event.roomId,
      index: event.index,
    );

    final gamePlayState = (state as GamePlay);
    _cellValues[event.index] = gamePlayState.room.turn.playerType;
    _gameRepository.checkForWinner(
      cellValues: _cellValues,
      roomId: gamePlayState.room.id,
    );
  }

  // Get data from listeners
  void _gameCreateRoomSuccess(
    GameCreateRoomSuccess event,
    Emitter<GameState> emit,
  ) {
    emit(GameLobby(event.roomId));
  }

  void _gameJoinRoomSuccess(
    GameJoinRoomSuccess event,
    Emitter<GameState> emit,
  ) {
    emit(GamePlay(
      room: event.room,
      cellValues: _cellValues,
      mySocketId: _gameRepository.socketId,
    ));
  }

  void _gameTappedOnCell(GameTappedOnCell event, Emitter<GameState> emit) {
    _cellValues[event.index] = event.choice;

    emit(GamePlay(
      room: event.room,
      cellValues: _cellValues,
      mySocketId: _gameRepository.socketId,
    ));

    // _gameRepository.checkForWinner(
    //   cellValues: _cellValues,
    //   roomId: (state as GamePlay).room.id,
    // );
  }

  void _gameDrawGame(GameDrawGame event, Emitter<GameState> emit) {
    emit(GameDraw(
      room: event.room,
      cellValues: _cellValues,
      mySocketId: _gameRepository.socketId,
    ));
  }

  void _gameWinGame(GameWinGame event, Emitter<GameState> emit) {
    emit(GameWin(
      room: event.room,
      message: event.message,
      cellValues: _cellValues,
      mySocketId: _gameRepository.socketId,
    ));
  }

  void _gameEndGame(GameEndGame event, Emitter<GameState> emit) {
    emit(GameEnd(
      room: event.room,
      message: event.message,
      cellValues: _cellValues,
      mySocketId: _gameRepository.socketId,
    ));
  }

  void _gameServerError(GameServerError event, Emitter<GameState> emit) {
    emit(GameError(event.message));
  }

  // Activate listeners
  void _gameActivateCreateRoomSuccessListener(
    GameActivateCreateRoomSuccessListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateCreateRoomSuccessListener(this);
  }

  void _gameActivateJoinRoomSuccessListener(
    GameActivateJoinRoomSuccessListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateJoinRoomSuccessListener(this);
  }

  void _gameActivateTappedOnCellListener(
    GameActivateTappedOnCellListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateTappedOnCellListener(this);
  }

  void _gameActivateDrawGameListener(
    GameActivateDrawGameListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateDrawGameListener(this);
  }

  void _gameActivateWinGameListener(
    GameActivateWinGameListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateWinGameListener(this);
  }

  void _gameActivateEndGameListener(
    GameActivateEndGameListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateEndGameListener(this);
  }

  void _gameActivateServerErrorListener(
    GameActivateServerErrorListener event,
    Emitter<GameState> emit,
  ) {
    _gameRepository.activateErrorListener(this);
  }
}
