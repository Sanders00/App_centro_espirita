import 'dart:convert';

import 'package:common/features/schedule/data/model/schedule.dart';
import 'package:http/http.dart' as http;

class ScheduleListRemoteAPIDataSource {
  Future<List<ScheduleModel>> getWeekdays() async {
    var client = http.Client();
    final result = <ScheduleModel>[];
    try {
      final response = await client.get(
        Uri.parse(
          'http://192.168.56.1:4000/Schedule',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['weekdays'].forEach((element) {
          result.add(ScheduleModel.fromJson(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
