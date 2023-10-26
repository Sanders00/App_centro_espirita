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
    mutation InsertWorkGroup($name: String = "", $desc: String = "", $work_groupXweekdays: work_groupXweekdays_arr_rel_insert_input = {data: {}}) {
      insert_work_group(objects: {name: $name, desc: $desc, work_groupXweekdays: $work_groupXweekdays}) {
      returning {
        name
        desc
          work_groupXweekdays {
            workgXweekdays_id
            work_group_id
            weekday_id
          }
        }
      }
    }
      ''', variables: {
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
    'work_groupXweekdays': arguments.data['work_groupXweekdays'],
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['insert_work_group']),
      );
    },
  );
}
