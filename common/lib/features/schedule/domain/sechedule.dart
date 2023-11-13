import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final int? id;
  final String weekday;
  final int workergXweekId;
  final int activityXweekId;

  ScheduleEntity({
    this.id,
    required this.weekday,
    required this.workergXweekId,
    required this.activityXweekId,
  });

  @override
  List<Object?> get props => [id];
}
