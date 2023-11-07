import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateWorkerActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
    mutation updateWorkerActivities($worker_id: Int!, $activities_id: Int!, $available_days: [String!]) {
      update_workerXactivities(where: {activities_id: {_eq: $activities_id}, worker_id: {_eq: $worker_id}}, _set: {available_days: $available_days}) {
        affected_rows
      }
    }
      ''', variables: {
    "activities_id": arguments.data['activities_id'],
    "worker_id": arguments.data['worker_id'],
    "available_days": arguments.data['available_days']
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
