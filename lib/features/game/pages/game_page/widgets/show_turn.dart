import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/game_bloc.dart';

class ShowTurn extends StatelessWidget {
  const ShowTurn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GamePlay) {
          final turn = state.room.turn;
          final mySocketId = state.mySocketId;
          final isMyTurn = mySocketId == turn.socketId;

          return Text(
            '${isMyTurn ? 'Your' : '${turn.nickname}\'s'} turn',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          );
        }
        return const SizedBox(
          height: 31,
        );
      },
    );
  }
}
