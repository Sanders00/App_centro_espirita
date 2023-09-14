import 'api/teste_api.dart';
import 'infra/custom_server.dart';
import 'utils/env_manager.dart';

void main() async {
  await CustomServer().initialize(
      handler: ApiTeste().handler,
      address: await EnvManager.get<String>(key: "server_address"),
      port: await EnvManager.get<int>(key: "server_port"));
}
