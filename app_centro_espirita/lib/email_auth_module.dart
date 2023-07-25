import 'package:app_centro_espirita/Services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/create_account_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseAuthMethodsModule extends WidgetModule {
  FirebaseAuthMethodsModule({super.key});

  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton((i) => FirebaseAuthMethods)
  ];

  @override
  Widget get view => const CreateAccountScreen();
  
}