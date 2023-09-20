import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllWorkers(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query GetAllWorkers {
        workers {
          worker_id
          name
          email
          phone
          whatsapp
          created_at
          updated_at
        }
      }
      ''');

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
