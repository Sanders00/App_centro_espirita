import 'dart:convert';

import 'package:common/features/schedule/data/model/schedule.dart';
import 'package:http/http.dart' as http;

class ActivitiesXScheduleListRemoteAPIDataSource {
  Future<List<ScheduleModel>> getActivitiesXWeekdays({
    required int id,
  }) async {
    var client = http.Client();
    final result = <ScheduleModel>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/Activities_X_Schedule',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"activities_id": id}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['activitiesXweekdays'].forEach((element) {
          result.add(ScheduleModel.fromJsonWeekdayWithId(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
