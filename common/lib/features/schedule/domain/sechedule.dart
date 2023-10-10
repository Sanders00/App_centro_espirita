import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final int? id;
  final String weekday;

  ScheduleEntity({
    this.id,
    required this.weekday,
  });

  @override
  List<Object?> get props => [id];
}
