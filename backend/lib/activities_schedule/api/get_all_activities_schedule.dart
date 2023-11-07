import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getAllActivitiesXSchedule(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query(r'''
      query getAllActivitiesXSchedule( $_eq: Int!){
        activitiesXweekdays(where: {activities_id: {_eq: $_eq}}) {
          weekday {
            weekdays_id
            weekday_name
          }
        }
      }
      ''', variables: {"_eq": arguments.data['activities_id']});

  return Response.ok(jsonEncode(hasuraResponse['data']));
}
