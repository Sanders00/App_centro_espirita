import 'package:dart_server/worker_activities/api/delete_worker_activities.dart';
import 'package:dart_server/worker_activities/api/get_all_worker_activities.dart';
import 'package:dart_server/worker_activities/api/insert_worker_activities.dart';
import 'package:dart_server/worker_activities/api/update_worker_activities.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkerXActivitiesResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/Get_Worker_X_Activities', getAllWorkerActivities),
        Route.post('/Worker_Activities_Available_Weekdays',
            getWorkerAvailableWeekdays),
        Route.post('/Worker_X_Activities', postWorkerActivities),
        Route.delete("/Worker_X_Activities", deleteWorkerActivities),
        Route.put("/Worker_X_Activities", updateWorkerActivities),
      ];
}
