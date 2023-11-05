import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllWorkerWorkGroup(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query(r'''
     query MyQuery($_eq: Int!) {
      workerXwork_group(where: {work_group_id: {_eq: $_eq}}) {
        worker {
          worker_id
          name
          email
          whatsapp
          phone
        }
      }
    }
      ''',variables: {"_eq": arguments.data['work_group_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}