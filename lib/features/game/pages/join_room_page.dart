import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/widgets/input_field.dart';
import '../../../core/common/widgets/main_button.dart';
import '../../../core/res/size_res.dart';
import '../../../core/res/string_res.dart';
import '../../../core/routes/app_route.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../core/utils/validators/nickname_validator.dart';
import '../../../core/utils/validators/room_id_validator.dart';
import '../bloc/game_bloc.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _roomIdController = TextEditingController();
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = context.read<GameBloc>();
    _gameBloc.add(GameActivateJoinRoomSuccessListener());
    _gameBloc.add(GameActivateServerErrorListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join & Play'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeRes.pagePadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              InputField(
                controller: _nicknameController,
                hintText: 'Enter your nickname',
                validator: nicknameValidator,
              ),

              const SizedBox(height: SizeRes.gapSmall),

              InputField(
                controller: _roomIdController,
                hintText: 'Enter your room ID',
                validator: roomIdValidator,
              ),

              const SizedBox(height: SizeRes.gapMedium),

              BlocListener<GameBloc, GameState>(
                listener: (context, state) {
                  if (state is GamePlay) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoute.gamePage,
                      (route) => route.isFirst,
                    );
                  } else if (state is GameError) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: MainButton(
                  label: StringRes.joinRoomLabel,
                  onTap: () {
                    final valid = _formKey.currentState!.validate();
                    if (valid) {
                      _gameBloc.add(GameJoinRoom(
                        nickname: _nicknameController.text.trim(),
                        roomId: _roomIdController.text.trim(),
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
