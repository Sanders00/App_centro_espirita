import 'package:equatable/equatable.dart';

class ActivitiesEntity extends Equatable {
  final int id;
  final String name;

  ActivitiesEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}
