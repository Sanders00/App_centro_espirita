import 'dart:convert';

import 'package:common/features/schedule/data/model/schedule.dart';
import 'package:http/http.dart' as http;

class WorkGroupXScheduleListRemoteAPIDataSource {
  Future<List<ScheduleModel>> getWorkGroupXWeekdays({
    required int id,
  }) async {
    var client = http.Client();
    final result = <ScheduleModel>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/WorkGroup_X_Schedule',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"work_group_id": id}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['work_groupXweekdays'].forEach((element) {
          result.add(ScheduleModel.fromJsonWeekdayWithId(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
