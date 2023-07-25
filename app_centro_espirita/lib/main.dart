import 'package:app_centro_espirita/CreateAccountPage.dart';
import 'package:app_centro_espirita/DashboardPage/DashboardPage.dart';
import 'package:app_centro_espirita/LoginPage.dart';
import 'package:app_centro_espirita/Services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/SettingsPage/SettingsPage.dart';
import 'package:app_centro_espirita/Services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));

}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => FirebaseAuthMethods)
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) =>  const LoginScreen(),),
    ChildRoute('/Create-Account', child: (context, args) =>  const CreateAccountScreen(),),
    ChildRoute('/Dashboard', child: (context, args) =>  const Dashboard(),),
    ChildRoute('/Configurações', child: (context, args) => const Settings(),),
  ];
}


class AppWidget extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'CEPAC',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      
    );
  }
}





