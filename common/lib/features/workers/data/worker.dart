import 'package:common/features/workers/domain/worker.dart';

class WorkerModel extends WorkerEntity {
  WorkerModel({
    required super.id,
    required super.name,
    required super.telephone,
    required super.email,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id'] as int,
      name: json['name'],
      telephone: json['telephone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson(WorkerModel instance) => <String, dynamic>{
        'id': instance.id,
        'name': instance.name,
        'telephone': instance.telephone,
        'email': instance.email
      };
}
