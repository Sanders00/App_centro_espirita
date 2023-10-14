import 'package:dart_server/work_group/api/get_all_work_groups.dart';
import 'package:shelf_modular/shelf_modular.dart';

class WorkGroupResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/work_groups', getAllWorkGroups),
       //Route.post('/work_groups', instertWorkers),
       //Route.delete('/work_groups', deleteWorkers),
       //Route.put('/work_groups', updateWorkers),
      ];
}