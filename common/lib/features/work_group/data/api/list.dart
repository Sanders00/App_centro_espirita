import 'dart:convert';

import 'package:common/features/work_group/data/model/work_group.dart';
import 'package:http/http.dart' as http;

class WorkGroupListRemoteAPIDataSource {
  Future<List<WorkGroupModel>> getWorkGroups() async {
    var client = http.Client();
    final result = <WorkGroupModel>[];
    try {
      final response = await client.get(
        Uri.parse(
          'http://192.168.56.1:4000/work_groups',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['work_group'].forEach((element) {
          result.add(WorkGroupModel.fromJson(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<WorkGroupModel?> postWorkGroups({
    required String name,
    required String desc,
    required List<dynamic> workXWeekdays,
  }) async {
    var jsonInsert = jsonEncode(<dynamic, dynamic>{
      'name': name,
      'desc': desc,
      'work_groupXweekdays': {
        "data": workXWeekdays
            .map((e) => {
                  "weekday_id": e,
                })
            .toList(),
      }
    });
    final response = await http.post(
        Uri.parse(
          'http://192.168.56.1:4000/work_groups',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonInsert);

    if (response.statusCode == 200) {
      return WorkGroupModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load work groups');
    }
  }

  Future deleteWorkGroups({
    required int id,
  }) async {
    final response = await http.delete(
      Uri.parse(
        'http://192.168.56.1:4000/work_groups',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete work groups');
    }
  }

  Future<WorkGroupModel?> updateWorkGroups({
    required int id,
    required String name,
    required String desc,
  }) async {
    final response = await http.put(
      Uri.parse(
        'http://192.168.56.1:4000/work_groups',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'id': id,
        'name': name,
        'desc': desc,
      }),
    );

    if (response.statusCode == 200) {
      return WorkGroupModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update work groups');
    }
  }
}
