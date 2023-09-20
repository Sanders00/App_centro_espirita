import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final int? id;
  final String weekday;
  final String startTime;
  final String endTime;

  ScheduleEntity({
    this.id,
    required this.weekday,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [id];
}
