import 'package:equatable/equatable.dart';

class WorkGroupEntity extends Equatable {
  final int id;
  final String name;
  final String desc;

  WorkGroupEntity({
    required this.id,
    required this.name,
    required this.desc,
  });

  @override
  List<Object?> get props => [id];
}
