import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> deleteWorkGroup(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.mutation(r'''
      mutation DeleteWorkGroup($id: Int!) {
        delete_work_group_by_pk(work_group_id: $id) {
          work_group_id
        }
      }
      ''', variables: {"id": arguments.data['id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
