import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> deleteWorkerActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
    mutation deleteWorkerActivities($worker_id: Int!) {
      delete_workerXactivities(where: {worker_id: {_eq: $worker_id}}) {
        affected_rows
      }
    }
      ''', variables: {"worker_id": arguments.data['worker_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
