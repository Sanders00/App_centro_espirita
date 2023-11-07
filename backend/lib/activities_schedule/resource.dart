import 'package:dart_server/activities_schedule/api/get_all_activities_schedule.dart';
import 'package:shelf_modular/shelf_modular.dart';

class ActivitiesXScheduleResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/Activities_X_Schedule', getAllActivitiesXSchedule),
      ];
}