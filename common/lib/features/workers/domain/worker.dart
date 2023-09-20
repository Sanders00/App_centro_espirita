import 'package:equatable/equatable.dart';

class WorkerEntity extends Equatable {
  final int? id;
  final String name;
  final String telephone;
  final String email;
  final String whatsapp;

  WorkerEntity({
    this.id,
    required this.name,
    required this.telephone,
    required this.email,
    required this.whatsapp,
  });

  @override
  List<Object?> get props => [id];
}
