import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> deleteWorkers(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
      mutation DeleteWorker($id: Int!) {
        delete_workers_by_pk(worker_id: $id) {
          name
          email
          phone
          whatsapp
          updated_at
          created_at
        }
      }
      ''', variables: {"id": arguments.params['id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}