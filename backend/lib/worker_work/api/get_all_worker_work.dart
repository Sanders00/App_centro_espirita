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
     query getAllWorkerWorkGroup($_eq: Int!) {
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
      ''', variables: {"_eq": arguments.data['work_group_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}

Future<Response> getWorkerAvailableWeekdays(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();
  var hasuraResponse = await hasuraConnect.query(r'''
    query getWorkerAvailableWeekdays($work_group_id: Int!, $worker_id: Int!) {
      workerXwork_group(where: {work_group_id: {_eq: $work_group_id}, worker_id: {_eq: $worker_id}}) {
        available_days
      }
    }
      ''', variables: {
    "work_group_id": arguments.data['work_group_id'],
    "worker_id": arguments.data['worker_id']
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
