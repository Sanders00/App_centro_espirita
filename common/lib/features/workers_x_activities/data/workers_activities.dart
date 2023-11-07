import 'package:common/features/workers_x_activities/domain/workers_activities.dart';

class WorkersActivitiesModel extends WorkersActivitiesEntity {
  WorkersActivitiesModel({
    required super.id,
    required super.workerId,
    required super.activityId,
    required super.availableWeekdays,
  });

  factory WorkersActivitiesModel.fromJson(Map<String, dynamic> json) {
    return WorkersActivitiesModel(
      id: json['workerXactivities_id'] as int,
      workerId: json['worker_id'] as int,
      activityId: json['activitie_id'] as int,
      availableWeekdays: json['available_days'] as List<String>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workerXactivities_id': id,
      'worker_id': workerId,
      'activitie_id': activityId,
      'available_days': availableWeekdays,
    };
  }
}
