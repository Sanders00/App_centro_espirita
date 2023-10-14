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
    mutation InsertWorkGroup($name: String!, $desc: String!) {
      insert_work_group_one(object: {name: $name, desc: $desc}) {
        work_group_id
        name
        desc
      }
    }
      ''', variables: {
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['insert_work_group_one']),
      );
    },
  );
}
