import 'package:common/features/schedule/domain/sechedule.dart';

class ScheduleModel extends ScheduleEntity {
  ScheduleModel({
    required super.id,
    required super.weekday,
    required super.startTime,
    required super.endTime,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as int,
      weekday: json['weekday'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson(ScheduleModel instance) {
    return {
      'id': instance.id,
      'weekday': instance.weekday,
      'startTime': instance.startTime,
      'endTime': instance.endTime
    };
  }
}
