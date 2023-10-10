import 'package:common/features/schedule/domain/sechedule.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel({
    required super.id,
    required super.weekday,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as int,
      weekday: json['weekday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weekday': weekday,
    };
  }
}
