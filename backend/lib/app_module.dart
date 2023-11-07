import 'package:dart_server/activities/resource.dart';
import 'package:dart_server/activities_schedule/resource.dart';
import 'package:dart_server/schedule/resource.dart';
import 'package:dart_server/work_group/resource.dart';
import 'package:dart_server/work_groupXschedule/resource.dart';
import 'package:dart_server/worker_activities/resource.dart';
import 'package:dart_server/worker_work/resource.dart';
import 'package:dart_server/workers/resource.dart';
import 'package:hasura_connect/hasura_connect.dart' hide Response;
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf.dart';

class AppModule extends Module {
  final String hasuraServerURL;
  final String hasuraGraphQLAdminSecret;

  AppModule({
    required this.hasuraServerURL,
    required this.hasuraGraphQLAdminSecret
  });

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HasuraConnect(
              hasuraServerURL, headers: {'x-hasura-admin-secret': hasuraGraphQLAdminSecret}
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', () => Response.ok('funcionando')),
        Route.resource(WorkerResource()),
        Route.resource(WorkGroupResource()),
        Route.resource(ScheduleResource()),
        Route.resource(WorkGroupXScheduleResource()),
        Route.resource(WorkerXWorkResource()),
        Route.resource(ActivitiesResource()),
        Route.resource(ActivitiesXScheduleResource()),
        Route.resource(WorkerXActivitiesResource()),
      ];
}
