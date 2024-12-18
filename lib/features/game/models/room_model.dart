import 'package:flutter/foundation.dart';

import 'player_model.dart';

@immutable
class RoomModel {
  final String id;
  final int playerCount;
  final int maxRounds;
  final int currentRound;
  final int turnIndex;
  final bool canJoin;
  final PlayerModel turn;
  final List<PlayerModel> players;

  const RoomModel({
    required this.id,
    required this.playerCount,
    required this.maxRounds,
    required this.currentRound,
    required this.turnIndex,
    required this.canJoin,
    required this.turn,
    required this.players,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['_id'],
      playerCount: map['playerCount'],
      maxRounds: map['maxRounds'],
      currentRound: map['currentRound'],
      turnIndex: map['turnIndex'],
      canJoin: map['canJoin'],
      turn: PlayerModel.fromMap(map['turn']),
      players: (map['players'] as List<dynamic>)
          .map((e) => PlayerModel.fromMap(e))
          .toList(),
    );
  }
}
