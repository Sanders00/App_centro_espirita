import 'package:common/features/workers_x_work/domain/worker_x_work.dart';

class WokerXWorkModel extends WorkerXWorkEntity {
  WokerXWorkModel({
    required super.id,
    required super.workerId,
    required super.workGroupId,
    required super.availableWeekdays,
  });

  factory WokerXWorkModel.fromJson(Map<String, dynamic> json) {
    return WokerXWorkModel(
      id: json['workerXwork_id'] as int,
      workerId: json['worker_id'],
      workGroupId: json['work_group_id'],
      availableWeekdays: json['available_days'],
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
