import 'package:equatable/equatable.dart';

class WorkerEntity extends Equatable {
  final int? id;
  final String name;
  final String telephone;
  final String email;

  WorkerEntity({
    this.id,
    required this.name,
    required this.telephone,
    required this.email,
  });

  @override
  List<Object?> get props => [id];
}
