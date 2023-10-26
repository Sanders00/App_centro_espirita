import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllSchedule(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query GetAllSchedule {
        weekdays(order_by: {weekdays_id: asc}) {
          weekdays_id
          weekday_name
        }
      }
      ''');

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
