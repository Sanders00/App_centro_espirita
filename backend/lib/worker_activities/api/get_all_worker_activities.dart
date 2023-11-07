import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllWorkerActivities(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query(r'''
     query getAllWorkerActivities($_eq: Int!) {
      workerXactivities(where: {activities_id: {_eq: $_eq}}) {
        worker {
          worker_id
          name
          email
          whatsapp
          phone
        }
      }
    }
      ''', variables: {"_eq": arguments.data['activities_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}

Future<Response> getWorkerAvailableWeekdays(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();
  var hasuraResponse = await hasuraConnect.query(r'''
    query getWorkerAvailableWeekdays($activities_id: Int!, $worker_id: Int!) {
      workerXactivities(where: {activities_id: {_eq: $activities_id}, worker_id: {_eq: $worker_id}}) {
        available_days
      }
    }
      ''', variables: {
    "activities_id": arguments.data['activities_id'],
    "worker_id": arguments.data['worker_id']
  });

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
