import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/res/size_res.dart';
import '../../../core/routes/app_route.dart';
import '../../../core/utils/copy_text.dart';
import '../bloc/game_bloc.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = context.read<GameBloc>();
    _gameBloc.add(GameActivateJoinRoomSuccessListener());
  }

  @override
  Widget build(BuildContext context) {
    final roomId = (_gameBloc.state as GameLobby).roomId;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GamePlay) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.gamePage,
            (route) => route.isFirst,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stay here'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeRes.pagePadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Text(
                'Copy the room ID using the copy button and send it to your opponent. Stay on this page, and you will be automatically redirected to the game once your opponent joins',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.error,
                ),
              ),

              const SizedBox(height: SizeRes.gapLarge),

              Text(
                roomId,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(height: SizeRes.gapSmall),

              IconButton.outlined(
                onPressed: () {
                  copyText(context: context, text: roomId);
                },
                icon: const Icon(Icons.copy_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
