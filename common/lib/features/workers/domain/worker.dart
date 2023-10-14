import 'package:equatable/equatable.dart';

class WorkerEntity extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String whatsapp;

  WorkerEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.whatsapp,
  });

  @override
  List<Object?> get props => [id];
}
