import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> insertActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
    mutation MyMutation($name: String = "", $desc: String = "", $activitiesXweekdays: activitiesXweekdays_arr_rel_insert_input = {data: {}}) {
      insert_activities(objects: {name: $name, desc: $desc, activitiesXweekdays: $activitiesXweekdays}) {
        returning {
          name
          desc
          activitiesXweekdays {
            activitiesXweekdays_id
            activities_id
            weekday_id
          }
        }
      }
    }
      ''', variables: {
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
    'activitiesXweekdays': arguments.data['activitiesXweekdays'],
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['insert_work_group']),
      );
    },
  );
}
