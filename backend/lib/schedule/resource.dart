import 'package:dart_server/schedule/api/get_all_schedule.dart';
import 'package:shelf_modular/shelf_modular.dart';

class ScheduleResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/Schedule', getAllSchedule),
      ];
}
