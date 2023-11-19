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
    mutation MyMutation($worker_id: Int!,$objects: [workerXwork_group_insert_input!] = {}) {
      delete_workerXwork_group(where: {worker_id: {_eq: $worker_id}}) {
        affected_rows
      }
      insert_workerXwork_group(objects: $objects) {
        returning {
          worker{
            worker_id
            name
            email
            phone
            whatsapp
          }
        }
      }
    }
      ''', variables: {
    "worker_id": arguments.data['worker_id'],
    "objects": arguments.data['objects'],
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
