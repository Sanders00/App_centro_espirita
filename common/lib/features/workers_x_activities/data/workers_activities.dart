import 'package:common/features/workers_x_work/domain/worker_x_work.dart';

class WorkerXWorkModel extends WorkerXWorkEntity {
  WorkerXWorkModel({
    required super.id,
    required super.workerId,
    required super.workGroupId,
    required super.availableWeekdays,
  });

  factory WorkerXWorkModel.fromJson(Map<String, dynamic> json) {
    return WorkerXWorkModel(
      id: json['id'] as int,
      workerId: json['workerId'] as int,
      workGroupId: json['workGroupId'] as int,
      availableWeekdays: json['availableWeekdays'] as List<String>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'workGroupId': workGroupId,
      'availableWeekdays': availableWeekdays,
    };
  }
}
