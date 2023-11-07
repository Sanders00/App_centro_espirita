import 'dart:convert';

import 'package:common/features/activities/data/model/activities.dart';
import 'package:http/http.dart' as http;

class ActivitiesListRemoteAPIDataSource {
  Future<List<ActivitiesModel>> getActivities() async {
    var client = http.Client();
    final result = <ActivitiesModel>[];
    try {
      final response = await client.get(
        Uri.parse(
          'http://192.168.56.1:4000/activities',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['activities'].forEach((element) {
          result.add(ActivitiesModel.fromJson(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<ActivitiesModel?> postActivities({
    required String name,
    required String desc,
    required List<dynamic> actXWeekdays,
  }) async {
    var jsonInsert = jsonEncode(<dynamic, dynamic>{
      'name': name,
      'desc': desc,
      'activitiesXweekdays': {
        "data": actXWeekdays
            .map((e) => {
                  "weekday_id": e,
                })
            .toList(),
      }
    });
    final response = await http.post(
        Uri.parse(
          'http://192.168.56.1:4000/activities',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonInsert);

    if (response.statusCode == 200) {
      return ActivitiesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load activities');
    }
  }

    Future deleteActivities({
    required int id,
  }) async {
    var jsonInsert = jsonEncode(<dynamic, dynamic>{
      'activities_id': id,
    });
    final response = await http.delete(
      Uri.parse(
        'http://192.168.56.1:4000/activities',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonInsert,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete activities');
    }
  }
}
