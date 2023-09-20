import 'dart:convert';

import 'package:common/features/workers/data/model/worker.dart';
import 'package:http/http.dart' as http;

class WorkerListRemoteAPIDataSource {
  Future<List<WorkerModel>> getAll() async {
    var client = http.Client();
    final result = <WorkerModel>[];
    try {
      final response = await client.get(
        Uri.parse(
          'http://192.168.56.1:4000',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        print(bodyResult);
        bodyResult['workers'].forEach((element) {
          result.add(WorkerModel.fromJson(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
