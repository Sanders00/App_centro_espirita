import 'package:equatable/equatable.dart';

class ActivitiesWeekdaysEntity extends Equatable {
  final int id;
  final int activityId;
  final int weekdaysId;

  ActivitiesWeekdaysEntity({
    required this.id,
    required this.activityId,
    required this.weekdaysId,
  });

  @override
  List<Object?> get props => [id, activityId, weekdaysId];
}
