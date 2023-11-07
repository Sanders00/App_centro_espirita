import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> deleteActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
      mutation deleteActivities($activities_id: Int!) {
        delete_activitiesXweekdays(where: {activities_id: {_eq: $activities_id}}) {
          affected_rows
        }
        delete_workerXactivities(where: {activities_id: {_eq: $activities_id}}) {
        affected_rows
      }
        delete_activities_by_pk(activities_id: $activities_id) {
          activities_id
        }
      }
      ''', variables: {"activities_id": arguments.data['activities_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
