import 'dart:convert';

import 'package:common/features/workers/data/model/worker.dart';
import 'package:http/http.dart' as http;

class WorkerXActivitiesListRemoteAPIDataSource {
  Future<List<WorkerModel>> getWorkersXActivities({
    required int id,
  }) async {
    var client = http.Client();
    final result = <WorkerModel>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/Get_Worker_X_Activities',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"activities_id": id}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['workerXactivities'].forEach((element) {
          result.add(WorkerModel.fromJsonWithId(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<String>> getWorkersAvailableWeekdays({
    required int activityId,
    required int workerId,
  }) async {
    var client = http.Client();
    final result = <String>[];
    try {
      final response = await client.post(
        Uri.parse(
          'http://192.168.56.1:4000/Worker_Activities_Available_Weekdays',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"activities_id": activityId, "worker_id": workerId}),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['workerXactivities'].forEach((element) {
          element['available_days'].forEach((element) {
            result.add(element);
          });
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<WorkerModel?> postWorkerActivities({
    required int activityId,
    required int workerId,
    required List<dynamic> availableWeekdays,
  }) async {
    final response = await http.post(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Activities',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'activities_id': activityId,
        'worker_id': workerId,
        'available_days': availableWeekdays,
      }),
    );

    if (response.statusCode == 200) {
      return WorkerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load workers');
    }
  }

  Future deleteWorkerActivities({
    required int id,
  }) async {
    final response = await http.delete(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Activities',
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

  Future<WorkerModel?> updateWorkerActivities({
    required int activityId,
    required int workerId,
    required List<dynamic> availableWeekdays,
  }) async {
    final response = await http.put(
      Uri.parse(
        'http://192.168.56.1:4000/Worker_X_Activities',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'activities_id': activityId,
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
