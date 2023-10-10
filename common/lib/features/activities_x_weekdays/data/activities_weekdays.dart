import 'package:common/features/activities_x_weekdays/domain/activities_weekdays.dart';

class ActivitiesWeekdaysModel extends ActivitiesWeekdaysEntity {
  ActivitiesWeekdaysModel({
    required super.id,
    required super.activityId,
    required super.weekdaysId,
  });

  factory ActivitiesWeekdaysModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesWeekdaysModel(
      id: json['id'] as int,
      activityId: json['activityId'] as int,
      weekdaysId: json['weekdaysId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityId': activityId,
      'weekdaysId': weekdaysId,
    };
  }
}
