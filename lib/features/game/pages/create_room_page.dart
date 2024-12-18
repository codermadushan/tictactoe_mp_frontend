import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/widgets/input_field.dart';
import '../../../core/common/widgets/main_button.dart';
import '../../../core/res/size_res.dart';
import '../../../core/res/string_res.dart';
import '../../../core/routes/app_route.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../core/utils/validators/nickname_validator.dart';
import '../bloc/game_bloc.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = context.read<GameBloc>();
    _gameBloc.add(GameActivateCreateRoomSuccessListener());
    _gameBloc.add(GameActivateServerErrorListener());
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your space'),
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

              const SizedBox(height: SizeRes.gapMedium),

              BlocListener<GameBloc, GameState>(
                listener: (context, state) {
                  if (state is GameLobby) {
                    Navigator.pushNamed(context, AppRoute.lobbyPage);
                  } else if (state is GameError) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: MainButton(
                  label: StringRes.createRoomLabel,
                  onTap: () {
                    final valid = _formKey.currentState!.validate();
                    if (valid) {
                      _gameBloc.add(GameCreateRoom(
                        _nicknameController.text.trim(),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
