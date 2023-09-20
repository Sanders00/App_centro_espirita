import 'package:common/features/workers_x_work/domain/worker_x_work.dart';

class WokerXWorkModel extends WorkerXWorkEntity {
  WokerXWorkModel({
    required super.id,
    required super.workerId,
    required super.workGroupId,
    required super.scheduleId,
  });

  factory WokerXWorkModel.fromJson(Map<String, dynamic> json) {
    return WokerXWorkModel(
      id: json['id'] as int,
      workerId: json['workerId'] as int,
      workGroupId: json['workGroupId'] as int,
      scheduleId: json['scheduleId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'workGroupId': workGroupId,
      'scheduleId': scheduleId,
    };
  }
}
