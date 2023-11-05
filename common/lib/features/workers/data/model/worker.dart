import 'package:common/features/workers/domain/worker.dart';

class WorkerModel extends WorkerEntity {
  WorkerModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.whatsapp,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['worker_id'] as int,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      whatsapp: json['whatsapp'],
    );
  }

  factory WorkerModel.fromJsonWithId(Map<String, dynamic> json) {
    return WorkerModel(
      id: json["worker"]['worker_id'] as int,
      name: json["worker"]['name'],
      phone: json["worker"]['phone'],
      email: json["worker"]['email'],
      whatsapp: json["worker"]['whatsapp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worker_id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp
    };
  }
}
