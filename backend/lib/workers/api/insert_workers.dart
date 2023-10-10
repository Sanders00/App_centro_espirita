import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> instertWorkers(
  Request request,
  Injector injector,
  ModularArguments arguments,
  
) async {
  final hasuraConnect = injector.get<HasuraConnect>();
  Map<String, dynamic> data = jsonDecode(await request.readAsString());

  var hasuraResponse = await hasuraConnect.mutation(r'''
      mutation InsertWorkers($workers: workers_insert_input!) {
        insert_workers(objects: [$workers]) {
          returning {
            worker_id
            name
            email
            phone
            whatsapp
            created_at
           updated_at
          }
        }
      }
      ''', variables: {"workers": data});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
