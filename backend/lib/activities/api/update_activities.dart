import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
  mutation updateActivities($activities_id: Int!, $name: String = "", $desc: String = "",$activitiesXweekdays:[activitiesXweekdays_insert_input!]!) {
    update_activities_by_pk(pk_columns: {activities_id: $activities_id}, _set: {name: $name, desc: $desc}) {
      name
      desc
    }
    delete_activitiesXweekdays(where: {activities_id: {_eq: $activities_id}}) {
      affected_rows
    }
    insert_activitiesXweekdays(objects: $activitiesXweekdays) {
      affected_rows
    }
  }
      ''', variables: {
    'activities_id': arguments.data['activities_id'],
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
    'activitiesXweekdays': arguments.data['activitiesXweekdays']
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['update_activities']),
      );
    },
  );
}
