import 'package:dart_server/workers/api/get_all_workers.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkerResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/workers', getAllWorkers),
      ];
}
