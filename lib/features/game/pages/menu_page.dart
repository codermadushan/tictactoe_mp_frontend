import 'package:flutter/material.dart';

import '../../../core/common/widgets/main_button.dart';
import '../../../core/common/widgets/theme_button.dart';
import '../../../core/res/size_res.dart';
import '../../../core/res/string_res.dart';
import '../../../core/routes/app_route.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make your choice'),
        centerTitle: true,
        actions: const [ThemeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeRes.pagePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            MainButton(
              label: StringRes.createRoomLabel,
              onTap: () {
                Navigator.pushNamed(context, AppRoute.createRoomPage);
              },
            ),

            const SizedBox(height: SizeRes.gapMedium),

            MainButton(
              label: StringRes.joinRoomLabel,
              onTap: () {
                Navigator.pushNamed(context, AppRoute.joinRoomPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
