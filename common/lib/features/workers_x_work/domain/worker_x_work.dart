import 'package:equatable/equatable.dart';

class WorkerXWorkEntity extends Equatable {
  final int? id;
  final int workerId;
  final int workGroupId;
  final int scheduleId;

  const WorkerXWorkEntity({
    this.id,
    required this.workerId,
    required this.workGroupId,
    required this.scheduleId,
  });

  @override
  List<Object?> get props => [id, workerId, workGroupId, scheduleId];
}
