import 'dart:io';

import 'package:dart_server/app_module.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf_io.dart' as io;

//import 'api/teste_api.dart';
//import 'infra/custom_server.dart';
//import 'utils/env_manager.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  final hasuraServerUrl = "http://192.168.56.1:8080/v1/graphql";

  final handler = const Pipeline().addHandler(
    Modular(
      module: AppModule(
        hasuraServerURL: hasuraServerUrl,
        hasuraGraphQLAdminSecret: 'myadminsecretkey',
      ),
    ),
  );

  final restServer = await io.serve(
    handler,
    '0.0.0.0',
    4000,
  );
  print(
    'Server online: ${restServer.address.host} '
    '${restServer.address.address}:${restServer.port}',
  );

//  await CustomServer().initialize(
//      handler: ApiTeste().handler,
//      address: await EnvManager.get<String>(key: "server_address"),
//      port: await EnvManager.get<int>(key: "server_port"));
}
