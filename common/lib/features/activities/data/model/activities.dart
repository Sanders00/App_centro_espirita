import 'package:common/features/activities/domain/activities.dart';

class ActivitiesModel extends ActivitiesEntity {
  ActivitiesModel({
    required super.id,
    required super.name,
    required super.desc,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      id: json['activities_id'] as int,
      name: json['name'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
    };
  }
}
