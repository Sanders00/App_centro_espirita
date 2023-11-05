import 'package:dart_server/worker_work/api/get_all_worker_work.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkerXWorkResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/Worker_X_Work_Group', getAllWorkerWorkGroup),
      ];
}