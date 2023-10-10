import 'package:equatable/equatable.dart';

class WorkXWeekdaysEntity extends Equatable {
  final int id;
  final int workeGroupId;
  final int weekdaysId;

  const WorkXWeekdaysEntity({
    required this.id,
    required this.workeGroupId,
    required this.weekdaysId,
  });

  @override
  List<Object?> get props => [id, workeGroupId, weekdaysId];
}
