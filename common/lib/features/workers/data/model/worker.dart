import 'package:common/features/workers/domain/worker.dart';

class WorkerModel extends WorkerEntity {
  WorkerModel({
    required super.id,
    required super.name,
    required super.telephone,
    required super.email,
    required super.whatsapp,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['worker_id'] as int,
      name: json['name'],
      telephone: json['phone'],
      email: json['email'],
      whatsapp: json['whatsapp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worker_id': id,
      'name': name,
      'phone': telephone,
      'email': email,
      'whatsapp': whatsapp
    };
  }
}
