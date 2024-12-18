import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/res/size_res.dart';
import '../../../bloc/game_bloc.dart';
import '../../../models/room_model.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = context.read<GameBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        RoomModel room;
        List<String> cellValues;
        String mySocketId;
        if (state is GamePlay) {
          room = state.room;
          cellValues = state.cellValues;
          mySocketId = state.mySocketId;
        } else if (state is GameDraw) {
          room = state.room;
          cellValues = state.cellValues;
          mySocketId = state.mySocketId;
        } else if (state is GameWin) {
          room = state.room;
          cellValues = state.cellValues;
          mySocketId = state.mySocketId;
        } else {
          // GameEnd
          final gameEndState = (state as GameEnd);
          room = gameEndState.room;
          cellValues = gameEndState.cellValues;
          mySocketId = gameEndState.mySocketId;
        }

        return AbsorbPointer(
          absorbing: mySocketId != room.turn.socketId,
          // absorbing: false,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: SizeRes.pagePadding / 4,
              crossAxisSpacing: SizeRes.pagePadding / 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _gameBloc.add(GameTapOnCell(
                    roomId: room.id,
                    index: index,
                  ));
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    borderRadius: BorderRadius.circular(SizeRes.borderRadius),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: Text(
                          cellValues[index],
                          style: TextStyle(
                            fontSize: constraints.maxWidth / 2,
                            color: colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
