import 'package:equatable/equatable.dart';

class ActivitiesEntity extends Equatable {
  final int id;
  final String name;
  final String desc;

  ActivitiesEntity({
    required this.id,
    required this.name,
    required this.desc,
  });

  @override
  List<Object?> get props => [id];
}
