import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class ButtonsInfo {
  String title;
  IconData icon;
  String path;
  ButtonsInfo({required this.title, required this.icon, required this.path});
}

List<ButtonsInfo> _buttonInfo = [
  ButtonsInfo(title: "DashBoard", icon: Icons.home, path:'/Dashboard'),
  ButtonsInfo(title: "Setting", icon: Icons.settings, path: '/Configurações'), 
];

int _currentIndex = 0;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

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
                  style: TextStyle(
                  ),
                ),
                trailing:  IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                    
              ),
              ...List.generate(
                  _buttonInfo.length,
                  (index) => Column(
                        children: [
                          Container(
                            decoration: index == _currentIndex
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Colors.green,
                                      Colors.lightGreen
                                    ]))
                                : null,
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
                                  _currentIndex = index;
                                  Modular.to.navigate(_buttonInfo[index].path);
                                  
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 0.1,
                          ),
                        ],
                      )
                      )
            ],
          ),
        ),
      ),
    );
  }
}