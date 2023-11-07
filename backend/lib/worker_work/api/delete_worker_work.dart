import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> deleteWorkerWork(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
    mutation deleteWorkerWork($worker_id: Int!) {
      delete_workerXwork_group(where: {worker_id: {_eq: $worker_id}}) {
        affected_rows
      }
    }
      ''', variables: {"worker_id": arguments.data['worker_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
