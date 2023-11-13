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
          'http://192.168.56.1:4000/Get_Worker_X_Work_Group',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"work_group_id": id}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['workerXwork_group'].forEach((element) {
          result.add(WorkerModel.fromJsonWithId(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<String>> getWorkersAvailableWeekdays(
      {required int workGroupId, required int workerId}) async {
    var client = http.Client();
    final result = <String>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/Worker_Available_Weekdays',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"work_group_id": workGroupId, "worker_id": workerId}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['workerXwork_group'].forEach((element) {
          result.add(element['work_groupXweekday']['weekday']['weekday_name']);
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<WorkerModel?> postWorkerWorkGroup({
    required int workerId,
    required List<dynamic> workgXweekId,
  }) async {
    var jsonInsert = workgXweekId
        .map((e) => {'worker_id': workerId, 'workgXweekdays_id': e})
        .toList();
    final response = await http.post(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Work_Group',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'objects': jsonInsert,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return WorkerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load workers');
    }
  }

  Future deleteWorkerWorkGroup({
    required int id,
  }) async {
    final response = await http.delete(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Work_Group',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'worker_id': id,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete workers');
    }
  }

  Future<WorkerModel?> updateWorkerWorkGroup({
    required int workGroupId,
    required int workerId,
    required List<dynamic> availableWeekdays,
  }) async {
    final response = await http.put(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Work_Group',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'work_group_id': workGroupId,
        'worker_id': workerId,
        'available_days': availableWeekdays,
      }),
    );

    if (response.statusCode == 200) {
      return WorkerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update workers');
    }
  }
}
