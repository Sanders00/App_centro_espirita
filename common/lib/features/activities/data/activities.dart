import 'package:common/features/activities/domain/activities.dart';

class ActivitiesModel extends ActivitiesEntity {
  ActivitiesModel({
    required super.id,
    required super.name,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      id: json['id'] as int,
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
