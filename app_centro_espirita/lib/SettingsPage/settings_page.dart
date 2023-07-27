import 'package:app_centro_espirita/utils/side_menu.dart';
import 'package:app_centro_espirita/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
