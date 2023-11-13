import 'package:common/features/schedule/domain/sechedule.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel({
    required super.id,
    required super.weekday,
    required super.workergXweekId,
    required super.activityXweekId,
  });

  factory ScheduleModel.fromJsonWeekdayWithId(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['weekday']['weekdays_id'] as int,
      weekday: json['weekday']['weekday_name'] as String,
      workergXweekId: json['workgXweekdays_id'] ?? -1,
      activityXweekId: json['activityXweekdays_id'] ?? -1,
    );
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['weekdays_id'] as int,
      weekday: json['weekday_name'] as String,
      workergXweekId: json['workgXweek_id'] ?? -1,
      activityXweekId: json['activityXweek_id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekdays_id': id,
      'weekday_name': weekday,
      'workgXweek_id': workergXweekId,
      'activityXweek_id': activityXweekId,
    };
  }
}
