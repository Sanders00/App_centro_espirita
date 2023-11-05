import 'package:dart_server/work_groupXschedule/api/get_all_work_groups_schedule.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkGroupXScheduleResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/WorkGroup_X_Schedule', getAllWorkGroupsSchedule),
      ];
}