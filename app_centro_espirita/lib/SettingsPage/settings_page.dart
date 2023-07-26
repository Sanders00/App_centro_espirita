import 'package:app_centro_espirita/utils/side_menu.dart';
import 'package:app_centro_espirita/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context,),
      drawer: const DrawerScreen(currentIndex: 2),
      body:  const Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 100),
            )
          ],
        ),
      ),
    );
  }
}
