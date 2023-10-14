import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllWorkGroups(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query GetAllWorkGroups {
        work_group(order_by: {name: asc}) {
        name
        desc
      }
    }
      ''');

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
