import 'package:flutter/foundation.dart';

@immutable
class PlayerModel {
  final String nickname;
  final String socketId;
  final String playerType;
  final int points;

  const PlayerModel({
    required this.nickname,
    required this.socketId,
    required this.playerType,
    required this.points,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      nickname: map['nickname'],
      socketId: map['socketId'],
      playerType: map['playerType'],
      points: map['points'],
    );
  }
}
