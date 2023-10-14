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

  return hasuraConnect.mutation(r'''
    mutation InsertWorker(
      $name: String!, $email: String!, $phone: String!,$whatsapp: String!) {
        insert_workers_one(object: {name: $name, email: $email, phone: $phone, whatsapp:$whatsapp}) {
          worker_id
          name
          email
          phone
          whatsapp
        }
    }
      ''', variables: {
    'name': arguments.data['name'],
    'email': arguments.data['email'] ?? '',
    'phone': arguments.data['phone'] ?? '',
    'whatsapp': arguments.data['whatsapp'] ?? '',
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['insert_workers_one']),
      );
    },
  );
}
