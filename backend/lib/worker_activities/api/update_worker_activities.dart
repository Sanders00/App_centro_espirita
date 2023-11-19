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
    mutation updateWorkerActivities($worker_id: Int!,$objects: [workerXactivities_insert_input!] = {}) {
      delete_workerXactivities(where: {worker_id: {_eq: $worker_id}}) {
        affected_rows
      }
      insert_workerXactivities(objects: $objects) {
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
