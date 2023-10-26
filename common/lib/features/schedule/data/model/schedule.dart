import 'package:common/features/schedule/domain/sechedule.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel({
    required super.id,
    required super.weekday,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['weekdays_id'] as int,
      weekday: json['weekday_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekdays_id': id,
      'weekday_name': weekday,
    };
  }
}
