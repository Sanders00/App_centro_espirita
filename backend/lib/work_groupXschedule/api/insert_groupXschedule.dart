import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> insertWorkGroup(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
    
      ''', variables: {
    'objects': arguments.data,
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['insert_work_groupXweekdays']),
      );
    },
  );
}
