import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ButtonsInfo {
  String title;
  IconData icon;
  String path;
  ButtonsInfo({required this.title, required this.icon, required this.path});
}

List<ButtonsInfo> _buttonInfo = [
  ButtonsInfo(
      title: "Trabalhadores", icon: Icons.table_chart, path: '/Trabalhadores'),
  ButtonsInfo(
      title: "Grupo de estudos",
      icon: Icons.table_chart,
      path: '/Grupo-de-Estudos'),
  ButtonsInfo(
      title: "Atividades", icon: Icons.table_chart, path: '/Atividades'),
  ButtonsInfo(
      title: "Reunião Pública",
      icon: Icons.table_chart,
      path: '/Reunião-Pública'),
  ButtonsInfo(title: "Setting", icon: Icons.settings, path: '/Configurações'),
];

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                  title: const Text(
                    'Admin Menu',
                    style: TextStyle(),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))),
              ...List.generate(
                _buttonInfo.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: index == widget.currentIndex
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.lightGreen]))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [Colors.black38, Colors.black12])),
                      child: ListTile(
                        title: Text(
                          _buttonInfo[index].title,
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            _buttonInfo[index].icon,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Modular.to.navigate(_buttonInfo[index].path);
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.1,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: const Text('Sair'),
                  leading: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.logout),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
