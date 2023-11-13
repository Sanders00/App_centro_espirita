import 'package:common/features/workers_x_work/domain/worker_x_work.dart';

class WokerXWorkModel extends WorkerXWorkEntity {
  WokerXWorkModel({
    required super.id,
    required super.workerId,
    required super.workgXweekId,
  });

  factory WokerXWorkModel.fromJson(Map<String, dynamic> json) {
    return WokerXWorkModel(
      id: json['workerXwork_id'] as int,
      workerId: json['worker_id'],
      workgXweekId: json['workgXweekday_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worker_id': workerId,
      'workgXweekday_id': workgXweekId,
    };
  }
}
