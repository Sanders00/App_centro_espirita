import 'package:dart_server/work_group/api/delete_work_group.dart';
import 'package:dart_server/work_group/api/get_all_work_groups.dart';
import 'package:dart_server/work_group/api/insert_work_group.dart';
import 'package:dart_server/work_group/api/update_work_group.dart';

import 'package:shelf_modular/shelf_modular.dart';

class WorkGroupResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/work_groups', getAllWorkGroups),
        Route.post('/work_groups', insertWorkGroup),
        Route.delete('/work_groups', deleteWorkGroup),
        Route.put('/work_groups', updateWorkGroup),
      ];
}
