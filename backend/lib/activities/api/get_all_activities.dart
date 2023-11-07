import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query getAllActivities {
        activities(order_by: {name: asc}) {
          activities_id
          name
          desc
      }
    }
      ''');

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
