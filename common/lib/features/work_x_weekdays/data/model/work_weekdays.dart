import 'package:common/features/work_x_weekdays/domain/work_weekdays.dart';

class WorkXWeekdayModel extends WorkXWeekdaysEntity {
  WorkXWeekdayModel({
    required super.id,
    required super.workeGroupId,
    required super.weekdaysId,
  });

  factory WorkXWeekdayModel.fromJson(Map<String, dynamic> json) {
    return WorkXWeekdayModel(
      id: json['id'] as int,
      workeGroupId: json['workeGroupId'] as int,
      weekdaysId: json['weekdaysId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workeGroupId': workeGroupId,
      'weekdaysId': weekdaysId,
    };
  }

}
