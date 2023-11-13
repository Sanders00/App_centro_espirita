import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateWorkerWork(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
    mutation MyMutation($_eq: Int!, $workgXweekdays_id: Int!) {
      update_workerXwork_group_many(updates: {where: {worker_id: {_eq: $_eq}}, _set: {workgXweekdays_id: $workgXweekdays_id}}) {
        affected_rows
      } 
    }
      ''', variables: {
    "worker_id": arguments.data['worker_id'],
    "workgXweekdays_id": arguments.data['workgXweekdays_id']
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
