import 'package:dart_server/workers/api/delete_worker.dart';
import 'package:dart_server/workers/api/get_all_workers.dart';
import 'package:dart_server/workers/api/insert_workers.dart';
import 'package:dart_server/workers/api/update_workers.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkerResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/workers', getAllWorkers),
        Route.post('/workers', instertWorkers),
        Route.delete('/workers', deleteWorkers),
        Route.put('/workers', updateWorkers),
      ];
}
