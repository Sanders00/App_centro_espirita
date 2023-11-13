import 'package:equatable/equatable.dart';

class WorkerXWorkEntity extends Equatable {
  final int? id;
  final int workerId;
  final int workgXweekId;

  const WorkerXWorkEntity({
    this.id,
    required this.workerId,
    required this.workgXweekId,
  });

  @override
  List<Object?> get props => [id, workerId];
}
