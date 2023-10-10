import 'package:equatable/equatable.dart';

class WorkersActivitiesEntity extends Equatable {
  final int id;
  final int workerId;
  final int activityId;
  final List<String> availableWeekdays;

  const WorkersActivitiesEntity({
    required this.id,
    required this.workerId,
    required this.activityId,
    required this.availableWeekdays,
  });

  @override
  List<Object?> get props => [id, workerId, activityId];
}
