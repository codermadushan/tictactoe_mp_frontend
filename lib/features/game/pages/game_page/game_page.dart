import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/size_res.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/pop_dialog.dart';
import '../../bloc/game_bloc.dart';
import 'widgets/game_grid.dart';
import 'widgets/score_board.dart';
import 'widgets/show_turn.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = context.read<GameBloc>();
    _gameBloc.add(GameActivateTappedOnCellListener());
    _gameBloc.add(GameActivateDrawGameListener());
    _gameBloc.add(GameActivateWinGameListener());
    _gameBloc.add(GameActivateEndGameListener());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameDraw) {
          popDialog(
            context: context,
            message: 'Game draw',
            buttonLabel: 'Play again',
            onTap: () {
              _gameBloc.add(GamePlayAgain());
              Navigator.pop(context);
            },
          );
        } else if (state is GameWin) {
          popDialog(
            context: context,
            message: state.message,
            buttonLabel: 'Play again',
            onTap: () {
              _gameBloc.add(GamePlayAgain());
              Navigator.pop(context);
            },
          );
        } else if (state is GameEnd) {
          popDialog(
            context: context,
            message: state.message,
            buttonLabel: 'Ok',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.menuPage,
                (route) => false,
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s Play'),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeRes.pagePadding,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  ScoreBoard(),

                  SizedBox(height: SizeRes.gapMedium),

                  GameGrid(),

                  SizedBox(height: SizeRes.gapLarge),

                  ShowTurn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
