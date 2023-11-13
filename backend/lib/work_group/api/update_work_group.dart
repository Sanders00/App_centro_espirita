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
  mutation UpdateWorkGroup($work_group_id: Int!, $name: String = "", $desc: String = "",$work_groupXweekdays:[work_groupXweekdays_insert_input!]!) {
    update_work_group_by_pk(pk_columns: {work_group_id: $work_group_id}, _set: {name: $name, desc: $desc}) {
      name
      desc
    }
    insert_work_groupXweekdays(objects: $work_groupXweekdays) {
      affected_rows
    }
  }
      ''', variables: {
    'work_group_id': arguments.data['work_group_id'],
    'name': arguments.data['name'],
    'desc': arguments.data['desc'] ?? '',
    'work_groupXweekdays': arguments.data['work_groupXweekdays']
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']['update_work_group']),
      );
    },
  );
}
