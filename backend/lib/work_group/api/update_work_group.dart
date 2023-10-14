import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateWorkGroup(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
  mutation UpdateWorkGroup($_eq: Int!, $name: String!, $desc: String!) {
    update_work_group(where: {work_group_id: {_eq: $_eq}}, _set: {name: $name, desc: $desc}) {
      affected_rows
    }
  }
      ''', variables: {
    '_eq': arguments.data['id'],
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['update_work_group']),
      );
    },
  );
}
