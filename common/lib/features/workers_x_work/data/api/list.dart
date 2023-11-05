import 'dart:convert';

import 'package:common/features/workers/data/model/worker.dart';
import 'package:http/http.dart' as http;

class WorkerXWorkGroupListRemoteAPIDataSource {
  Future<List<WorkerModel>> getWorkersXWorkGroups({
    required int id,
  }) async {
    var client = http.Client();
    final result = <WorkerModel>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/Worker_X_Work_Group',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"work_group_id": id}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['work_groupXweekdays'].forEach((element) {
          result.add(WorkerModel.fromJsonWithId(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
