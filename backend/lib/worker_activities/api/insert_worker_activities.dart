import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> postWorkerActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
     mutation postWorkerActivities($objects: [workerXactivities_insert_input!] = {}) {
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
    "objects": arguments.data['objects'],
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
