import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateWorkers(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
  mutation UpdateWorker($_eq: Int!, $name: String!, $email: String!, $phone: String!, $whatsapp: String!) {
    update_workers(where: {worker_id: {_eq: $_eq}}, _set: {name: $name, email: $email, phone: $phone, whatsapp: $whatsapp}) {
      affected_rows
    }
  }
      ''', variables: {
    '_eq': arguments.data['id'],
    'name': arguments.data['name'],
    'email': arguments.data['email'] ?? '',
    'phone': arguments.data['phone'] ?? '',
    'whatsapp': arguments.data['whatsapp'] ?? '',
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['update_workers']),
      );
    },
  );
}
