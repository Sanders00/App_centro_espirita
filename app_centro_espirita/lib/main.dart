import 'package:app_centro_espirita/DashboardPage/dashboard_page.dart';
import 'package:app_centro_espirita/create_account_page.dart';
import 'package:app_centro_espirita/crud_page/grupo_estudos_crud_page.dart';
import 'package:app_centro_espirita/crud_page/trabalhador_crud_page.dart';
import 'package:app_centro_espirita/forgot_passowrd_page.dart';
import 'package:app_centro_espirita/login_page.dart';
import 'package:app_centro_espirita/Services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/SettingsPage/settings_page.dart';
import 'package:app_centro_espirita/Services/firebase_database_methods.dart';
import 'package:app_centro_espirita/Services/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppModule extends Module {

  streamBuilderRoute(Widget widget){
    return  StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return widget;
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const LoginScreen();
                  },
                );
  }

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => const LoginScreen()),
        Bind.lazySingleton((i) => FirebaseAuthMethods(FirebaseAuth.instance)),
        Bind.lazySingleton((i) => FirebaseDBMethods(FirebaseFirestore.instance))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => streamBuilderRoute(const Dashboard())),
        ChildRoute(
          '/Criar-Conta',
          child: (context, args) => const CreateAccountScreen() ,
        ),
        ChildRoute(
          '/Dashboard',
          child: (context, args) => streamBuilderRoute(const Dashboard()),
        ),
        ChildRoute(
          '/Configurações',
          child: (context, args) => streamBuilderRoute(const SettingsPage()),
        ),
        ChildRoute(
          '/Trabalhadores',
          child: (context, args) => streamBuilderRoute(const WorkerCrudPage()),
        ),
        ChildRoute(
          '/Grupo-de-Estudos',
          child: (context, args) => streamBuilderRoute(const GrupoEstudosCrudPage()),
        ),
        ChildRoute(
          '/Esqueci-Minha-Senha',
          child: (context, args) => const ForgotPasswordPage(),
        ),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.isModuleReady<AppModule>();
    return MaterialApp.router(
      title: 'CEPAC',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}


