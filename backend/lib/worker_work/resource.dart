import 'package:dart_server/worker_work/api/delete_worker_work.dart';
import 'package:dart_server/worker_work/api/get_all_worker_work.dart';
import 'package:dart_server/worker_work/api/post_worker_work.dart';
import 'package:dart_server/worker_work/api/update_worker_work.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkerXWorkResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/Get_Worker_X_Work_Group', getAllWorkerWorkGroup),
        Route.post('/Worker_Available_Weekdays', getWorkerAvailableWeekdays),
        Route.post('/Worker_X_Work_Group', postWorkerWork),
        Route.delete("/Worker_X_Work_Group", deleteWorkerWork),
        Route.put("/Worker_X_Work_Group", updateWorkerWork),
      ];
}