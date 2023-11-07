import 'package:dart_server/activities/api/delete_activitity.dart';
import 'package:dart_server/activities/api/get_all_activities.dart';
import 'package:dart_server/activities/api/insert_activities.dart';
import 'package:shelf_modular/shelf_modular.dart';

class ActivitiesResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/activities', getAllActivities),
        Route.post('/activities', insertActivities),
        Route.delete('/activities', deleteActivities),
      ];
}
